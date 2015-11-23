class RestaurantsController < ApplicationController
  require 'kamjest_communicator'

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
    restaurant = Restaurant.find(params[:restaurant_id])
    dates = KamjestCommunicator.new(restaurant).get_menus
    dates.each do |date|
      restaurant.menus.where(date: date['date']).destroy_all
      date['offers'].each do |offer|
        unless restaurant.kamjest_id == 'selih' && offer['type'] == 'KOSILO'
          Menu.new(description: offer['text'], price: offer['price'], date: date['date'], restaurant: restaurant, regular: false).save
        end
      end
    end
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :default_price, :telephone_number, :menu_link, :kamjest_id)
  end
end
