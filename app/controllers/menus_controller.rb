class MenusController < ApplicationController
  def new
    @menu = Menu.new
    @menu.restaurant = Restaurant.find params[:restaurant_id]
    @menu.price = @menu.restaurant.default_price
    @menu.date = params[:date] unless params[:date].nil?
  end

  def edit
    @menu = Menu.find params[:id]
  end

  def create
    menu_params_array[:description].each_with_index do |description, i|
      if description != ''
        menu = Menu.new(description: description, price: menu_params_array[:price][i])
        menu.restaurant_id = menu_params_array[:restaurant_id]
        menu.date = menu_params_array[:date]
        menu.save
      end
    end
    redirect_to restaurant_path(menu_params_array[:restaurant_id])
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
    params.require(:menu).permit(:restaurant_id, :date, :price, :description)
  end

  def menu_params_array
    @menu_params_array ||= params.require(:menu).permit(:restaurant_id, :date, price: [], description: [])
  end
end