class DashboardController < ApplicationController
  def index
    @restaurants = Restaurant.order :name
    @comments = Comment.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @comment = Comment.new
  end
end