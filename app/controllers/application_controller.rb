class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [ :top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning, :danger

  protected
  def after_sign_in_path_for(resource)
    posts_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path(resource)
  end

  def move_to_index
    unless user_signed_in? == current_user.name
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
