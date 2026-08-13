class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:username, :address, :city, :postal_code, :province_id]
    )

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:username, :address, :city, :postal_code, :province_id]
    )

    devise_parameter_sanitizer.permit(
      :sign_in,
      keys: [:username]
    )
  end
end