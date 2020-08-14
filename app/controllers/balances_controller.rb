class BalancesController < ApplicationController
  def index
    render json: balances
  end

  private

  def balances
    return fetch_splitwise if current_group.has_splitwise?
    return fetch_sr if current_group.has_sr?
    return []
  end

  def fetch_sr
    begin
      app_id = current_group.sr_id
      response = HTTParty.get("http://www.shortreckonings.com/ajax.php?tid=#{app_id}&token=54&caller=model&action=payments&")
      JSON.parse(response.body)['data']['totals'].map { |balance|
        user = {
          balance: (balance['own'].to_i - balance['owes'].to_i) / 100.0
        }

        user[:name] = User.select(:username).find_by_shortreckonings_id(balance['pid']).try(:username) || balance['pid']
        user
      }[0...-1].sort_by { |u| u[:balance] }
    rescue
      []
    end
  end

  def fetch_splitwise
    begin
      response = HTTParty.get(current_group.splitwise_url)
      JSON.parse(response.body)['balances'].map do |balance|
        {
          name: balance['name'],
          balance: balance['amount']
        }
      end
    rescue
      []
    end
  end
end
