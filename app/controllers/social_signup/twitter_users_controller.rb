require_dependency "social_signup/application_controller"

module SocialSignup
  class TwitterUsersController < ApplicationController
    include SocialSignup::Twitter
    
    def signup
      if !authorized?
        return redirect_to_fb_auth
      end

      create_user_incl_oauth_token
    end
    
  end
end
