class DashboardController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end
end