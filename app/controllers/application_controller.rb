class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def authorize_admin
    if user_signed_in?
      return if current_user.admin?
    end

    redirect_to root_path, alert: I18n.t(:admin_rights_needed)
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email language password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def render_not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  private

  def set_locale
    I18n.locale = user_signed_in? ? current_user.language : I18n.default_locale
  end
end
