require_dependency "social_signup/application_controller"

module SocialSignup
  class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.authenticate(params[:email], params[:password])
      if user
        login_user(user)
        redirect_to root_url, :notice => "Logged in!"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end

    def destroy
      logout_user
      redirect_to root_url, :notice => "Logged out!"
    end
  end
end
