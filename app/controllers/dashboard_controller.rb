class DashboardController < ApplicationController
  def index
    Restaurant.connection.execute "select setseed(#{seed})"
    @restaurants = Restaurant.order 'random()'
    @comments = Comment.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @comment = Comment.new
  end

  private

  def seed
    today = Date.today + 1
    Random.new(today.day * today.month * today.year).rand - 1
  end
end
