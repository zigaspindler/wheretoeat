class DashboardController < ApplicationController
  def index
    Restaurant.connection.execute "select setseed(#{seed})"
    @restaurants = Restaurant.order 'random()'
    @comments = Comment.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @comment = Comment.new
    @top_5 = top_5_voted
  end

  private

  def seed
    today = Date.today + 1
    Random.new(today.day * today.month * today.year).rand - 1
  end

  def top_5_voted
    ActiveRecord::Base.connection.exec_query("
      SELECT restaurants.name, COUNT(votes) as res_votes
      FROM restaurants
      LEFT JOIN votes as votes ON votes.restaurant_id = restaurants.id
      WHERE votes.date = '#{Date.today}'
      GROUP BY restaurants.id
      ORDER BY res_votes DESC
      LIMIT 5").rows
  end
end
