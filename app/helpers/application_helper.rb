module ApplicationHelper
  def current_group
    @current_group ||= current_user.group
  end

  def flash_class_mapper(type)
    {
      error: 'alert-danger',
      notice: 'alert-success'
    }[type.to_sym]
  end
end
