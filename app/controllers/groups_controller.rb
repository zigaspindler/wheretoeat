class GroupsController < ApplicationController
  def show
    @group = current_group
    @user = User.new
    @restaurants = Restaurant.order(:name)
  end

  def update
    current_group.update_attributes group_params
    flash[:notice] = 'Updated!'
    redirect_to group_path
  end

  def add_user
    user = User.new user_params
    user.password = '12345678'
    user.email = "#{user.username}@wheretoeat.com"
    user.group = current_group
    begin
      user.save
      flash[:notice] = 'User added!'
    rescue
      flash[:error] = 'Username already exists!'
    ensure
      redirect_to group_path
    end
  end

  def update_restaurants
    restaurants_params.each do |res|
      restaurant = Restaurant.find res[:id]
      if current_group.restaurants.include?(restaurant) && !res[:enabled]
        current_group.restaurants.delete restaurant
      elsif !current_group.restaurants.include?(restaurant) && res[:enabled]
        current_group.restaurants << restaurant
      end
    end
    flash[:notice] = 'Updated!'
    redirect_to group_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :sr_id)
  end

  def user_params
    params.require(:user).permit(:username)
  end

  def restaurants_params
    params.require(:restaurant_ids).map do |k, v|
      {
        id: k.to_i,
        enabled: v == 'true'
      }
    end
  end
end
