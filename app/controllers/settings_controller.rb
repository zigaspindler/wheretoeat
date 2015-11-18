class SettingsController < ApplicationController
  SETTINGS = ['collapsed']

  def index
    @settings = SETTINGS
  end

  def create
    current_user.send("#{params[:name]}=", params[:value])
    current_user.save
    render json: {success: true}
  end
end
