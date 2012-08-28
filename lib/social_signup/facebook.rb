module SocialSignup  
  module Facebook

      def authorized?
        !params[:code].blank?
      end

      def redirect_to_fb_auth(my_url_encoded)
        require 'cgi'
        session[:state] = (0...8).map{65.+(rand(25)).chr}.join
        dialog_url = "http://www.facebook.com/dialog/oauth?client_id=" +
           SocialSignup::FACEBOOK_APP_ID + 
           "&redirect_uri=" + 
           my_url_encoded + 
           "&state=#{session[:state]}" +
           "&scope=email";
        redirect_to dialog_url
      end

      def create_user_incl_oauth_token(my_url_encoded)
        if(session[:state].present? && (session[:state] == params[:state]))
          require 'open-uri'      
          token_url = "https://graph.facebook.com/oauth/access_token?" +
            "client_id=" + SocialSignup::FACEBOOK_APP_ID + "&redirect_uri=" + my_url_encoded +
            "&client_secret=" + SocialSignup::FACEBOOK_APP_SECRET + "&code=" + params[:code];

          r = open(token_url).read
          params = CGI::parse(r)
          graph_url = "https://graph.facebook.com/me?access_token=" + params['access_token'][0];

          user_params = ActiveSupport::JSON.decode(open(graph_url).read)
          user = ::User.new
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