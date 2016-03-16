class GroupsController < ApplicationController
  def show
    @group = current_group
    @user = User.new
  end

  def update
    current_group.update_attributes group_params
    redirect_to group_path
  end

  def add_user
    user = User.new user_params
    user.password = '12345678'
    user.email = "#{user.username}@wheretoeat.com"
    user.group = current_group
    begin
      user.save
    rescue
      flash[:error] = 'Username already exists!'
    ensure
      redirect_to group_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :sr_id)
  end

  def user_params
    params.require(:user).permit(:username)
  end
end
