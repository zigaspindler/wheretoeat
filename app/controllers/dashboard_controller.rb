class DashboardController < ApplicationController
  def index
    Restaurant.connection.execute "select setseed(#{seed})"
    @restaurants = Restaurant.order 'random()'
    @comments = Comment.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @comment = Comment.new
    @top_5 = top_for_date Date.today
    @last_3_days = last_3_days
    @balances = balances
  end

  private

  def seed
    today = Date.today + 1
    Random.new(today.day * today.month * today.year).rand - 1
  end

  def top_for_date(date, top = 5)
    ActiveRecord::Base.connection.exec_query("
      SELECT restaurants.name, COUNT(votes) as res_votes
      FROM restaurants
      LEFT JOIN votes as votes ON votes.restaurant_id = restaurants.id
      WHERE votes.date = '#{date}'
      GROUP BY restaurants.id
      ORDER BY res_votes DESC
      LIMIT #{top}").rows
  end

  def last_3_days
    top = []
    date = Date.today - 1
    stop = date - 2
    while date >= stop
      if date.wday == 6 || date.wday == 0
        stop -= 1
      else
        top << {date: date, restaurant: top_for_date(date, 1).first.try(:first)}
      end
      date -= 1
    end
    top
  end

  def balances
    app_id = ENV['SR_APP_ID']
    return [] unless app_id
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
