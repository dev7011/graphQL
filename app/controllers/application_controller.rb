class ApplicationController < ActionController::Base
  # Uncomment to require authentication by default
  # before_action :authenticate_user!

  # Permit additional Devise parameters (e.g. :role) for sign_up and account_update
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end
