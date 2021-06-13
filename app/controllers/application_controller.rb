class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :prevent_demo_modification, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password)}
    end

    def prevent_demo_modification
        if params["controller"] == "devise/registrations" && (params[:action] == "edit" || params[:action] == "update" || params[:action] == "destroy")
            if current_user.email == "demouser@gmail.com"
                redirect_to rooms_path, notice: "The Demo User account CANNOT be altered!"
            end
        end
    end
end
