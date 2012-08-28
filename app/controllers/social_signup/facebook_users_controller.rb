require_dependency "social_signup/application_controller"

module SocialSignup
  
  class FacebookUsersController < ApplicationController
    include SocialSignup::Facebook
    
    def signup
        my_url = "http://localhost:3000/social_signup/facebook_users/signup" #TODO: Hardcoded
        my_url_encoded = CGI.escape(my_url)
        
        if(!authorized?)
          return redirect_to_fb_auth(my_url_encoded)
        end
          
        create_user_incl_oauth_token(my_url_encoded)
    end
    
  end
end
