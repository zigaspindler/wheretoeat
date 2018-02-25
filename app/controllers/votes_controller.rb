class VotesController < ApplicationController

  def show
    date = Date.today
    @top_restaurant_id = ActiveRecord::Base.connection.exec_query("
      SELECT restaurants.id
      FROM restaurants
      LEFT JOIN votes ON votes.restaurant_id = restaurants.id
      WHERE votes.date = '#{date}'
      AND votes.group_id = #{current_group.id}
      GROUP BY restaurants.id
      ORDER BY COUNT(votes) DESC
      LIMIT 1").try(:first).try do |r|
        r['id']
      end
    @menus = {}
    Vote.where(date: date, group: current_group).includes(:restaurant, :user, :menu, :comment).order('restaurants.name ASC, users.username ASC').each do |v|
      key = "#{v.restaurant_id}_#{v.menu_id}"
      @menus[key] ||= {
        restaurant: v.restaurant,
        comments: [],
        voters: []
      }
      if v.menu.present?
        @menus[key][:text] = v.menu.description
      end
      if v.comment.present?
        @menus[key][:comments] << v.comment
      end
      @menus[key][:voters] << v.user.username
    end
  end

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
