require_dependency "social_signup/application_controller"

module SocialSignup
  class FacebookUsersController < ApplicationController
    
    def signup
      #TODO: Put these in initializer
        app_id = "337702879651329"
        app_secret = "1b526efbf36fc64bb51754633adcb248"
        my_url = "http://localhost:3000/social_signup/facebook_users/signup" #TODO: Hardcoded
        my_url_encoded = CGI.escape(my_url)
        code = params[:code]
        
        if(code.blank?)
          require 'cgi'
          session[:state] = (0...8).map{65.+(rand(25)).chr}.join
          dialog_url = "http://www.facebook.com/dialog/oauth?client_id=" +
             app_id + 
             "&redirect_uri=" + 
             my_url_encoded + 
             "&state=#{session[:state]}" +
             "&scope=email";
          
          return redirect_to dialog_url
        end
        if(session[:state].present? && (session[:state] == params[:state]))
          require 'open-uri'      
          token_url = "https://graph.facebook.com/oauth/access_token?" +
            "client_id=" + app_id + "&redirect_uri=" + my_url_encoded +
            "&client_secret=" + app_secret + "&code=" + code;
          
          r = open(token_url).read
          params = CGI::parse(r)
          graph_url = "https://graph.facebook.com/me?access_token=" + params['access_token'][0];
                              
          user_params = ActiveSupport::JSON.decode(open(graph_url).read)
          user = User.new
          user.email = user_params["email"]
          user.first_name = user_params["first_name"]
          user.last_name = user_params["last_name"]
          user.facebook_user_id = user_params["id"]
          user.facebook_oauth_token = params['access_token'][0]
          
          if user.save
            login_user(user)
            if COLLECT_EMAIL_AND_PASSWORD
              redirect_to edit_user_path(user)
            else
              redirect_to root_path, :notice => "Thank you for signing up!"
            end
          else
            redirect_to root_path, :notice => "That didnt work?!"
          end
        elsif
          raise Exception.new "The state does not match. You may be a victim of CSRF."
        end
    end
    
  end
end
