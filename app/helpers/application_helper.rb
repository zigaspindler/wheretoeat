module ApplicationHelper
  def current_group
    @current_group ||= current_user.group
  end
end
