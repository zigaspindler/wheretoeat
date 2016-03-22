class BalancesController < ApplicationController
  def index
    render json: balances
  end

  private

  def balances
    app_id = current_group.sr_id
    return [] if app_id.nil? || app_id == ''
    begin
      response = HTTParty.get("http://www.shortreckonings.com/ajax.php?tid=#{app_id}&token=54&caller=model&action=payments&")
      JSON.parse(response.body)['data']['totals'].map { |balance|
        user = {
          balance: balance['own'].to_i - balance['owes'].to_i
        }

        user[:name] = User.find_by(shortreckonings_id: balance['pid']).try(:username) || balance['pid']
        user
      }[0...-1].sort_by { |u| u[:balance] }
    rescue
      []
    end
  end
end
