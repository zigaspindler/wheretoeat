class DashboardController < ApplicationController
  def index
    @restaurants = Restaurant.order :name
  end
end