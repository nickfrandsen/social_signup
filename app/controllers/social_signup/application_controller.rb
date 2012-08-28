module SocialSignup
  class ApplicationController < ActionController::Base
    helper_method :current_user

    private
    
    def login_user(user)
      session[:user_id] = user.id
    end
    
    def logout_user
      session[:user_id] = nil
    end

    def current_user
      @current_user ||= ::User.find(session[:user_id]) if session[:user_id]
    end
  end
end
