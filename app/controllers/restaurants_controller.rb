class RestaurantsController < ApplicationController
  before_action :admin?, except: [:index, :show]

  def index
    @restaurants = Restaurant.order :name
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    restaurant = Restaurant.new restaurant_params
    restaurant.save
    redirect_to restaurants_path
  end

  def show
    @restaurant = Restaurant.find params[:id]
  end

  def edit
    @restaurant = Restaurant.find params[:id]
  end

  def update
    restaurant = Restaurant.find params[:id]
    restaurant.update restaurant_params
    restaurant.save
    redirect_to restaurants_path
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to restaurants_path
  end

  def update_menus
    if Restaurant.find(params[:restaurant_id]).update_menus
      render json: {status: 'success'}, status: 200
    else
      render json: {status: 'failed'}, status: 500
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :default_price, :telephone_number, :menu_link, :menu_parser, :kamjest_id)
  end
end
