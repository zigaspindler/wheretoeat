class MenusController < ApplicationController
  def new
    @menu = Menu.new
    @menu.restaurant = Restaurant.find params[:restaurant_id]
    @menu.price = @menu.restaurant.default_price
    @menu.date = params[:date] if not params[:date].nil?
  end

  def edit
    @menu = Menu.find params[:id]
  end

  def create
    menu = Menu.new menu_params
    menu.save
    redirect_to restaurant_path(menu.restaurant)
  end

  def update
    menu = Menu.find params[:id]
    menu.update menu_params
    menu.save
    redirect_to restaurant_path(menu.restaurant)
  end

  def destroy
    menu = Menu.find(params[:id]).destroy
    redirect_to restaurant_path(menu.restaurant)
  end

  private

  def menu_params
    params.require(:menu).permit(:description, :restaurant_id, :date, :price)
  end
end