class AdminController < ApplicationController
  before_action :admin?

  def show
    @group = Group.new
  end

  def create_group
    group = Group.new group_params
    group.save

    user = User.new user_params
    user.password = '12345678'
    user.email = "#{user.username}@wheretoeat.com"
    user.group = group
    user.save

    redirect_to admin_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :sr_id)
  end

  def user_params
    params.require(:group).require(:user).permit(:username)
  end
end
