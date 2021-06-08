class CallbacksController < ApplicationController
    # Presently: If email conflicts, signs into the same email user.
    # Not a security issue, but not an ideal approach either.
    def github
        @user = User.from_omniauth(request.env["omniauth.auth"])
        unless User.find_by(email: @user.email).nil? 
            @user = User.find_by(email: @user.email)
        end
        sign_in_and_redirect @user
    end

    def google_oauth2
        @user = User.from_omniauth(request.env["omniauth.auth"])
        unless User.find_by(email: @user.email).nil? 
            @user = User.find_by(email: @user.email)
        end
        sign_in_and_redirect @user
    end

    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        unless User.find_by(email: @user.email).nil? 
            @user = User.find_by(email: @user.email)
        end
        sign_in_and_redirect @user
    end

    def failure
        redirect_to root_path
    end

end
