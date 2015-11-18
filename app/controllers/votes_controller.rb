class VotesController < ApplicationController
  def create
    vote = Vote.find_or_create_by user: current_user, date: Date.today
    vote.restaurant_id = params[:restaurant_id]
    vote.save
    redirect_to root_path
  end

  def destroy
    Vote.where(user: current_user, date: Date.today).destroy_all
    redirect_to root_path
  end
end
