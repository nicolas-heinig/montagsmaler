module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action proc { redirect_to root_path }, only: %i[new create]

    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        flash[:notice] = confirmation_notice(account_update_params)
        bypass_sign_in resource, scope: resource_name
        respond_with resource, location: after_update_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    private

    def confirmation_notice(params)
      I18n.t(:user_saved, locale: params[:language])
    end
  end
end
