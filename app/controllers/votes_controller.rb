class VotesController < ApplicationController
  def create
    vote = Vote.find_or_create_by user: current_user, date: Date.today
    if params[:menu_id].nil?
      menu_id = nil
      restaurant_id = params[:restaurant_id]
    else
      menu_id = params[:menu_id]
      restaurant_id = Menu.find(params[:menu_id]).restaurant_id
    end
    vote.menu_id = menu_id
    vote.restaurant_id = restaurant_id
    vote.group = current_group
    vote.save
    redirect_to root_path
  end

  def destroy
    Vote.where(user: current_user, date: Date.today).destroy_all
    redirect_to root_path
  end
end
