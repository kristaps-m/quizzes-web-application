class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    def index
      render 'show'
    end    

    private
  
    # This private method is for new User fields [name, lastname] (create, edit)
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end
  end