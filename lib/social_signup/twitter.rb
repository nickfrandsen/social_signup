module SocialSignup  
  module Twitter
   
    def authorized?
      !params[:complete].blank?
    end
    
    def redirect_to_fb_auth
      oauth = OAuth::Consumer.new(TWITTER_KEY, TWITTER_SECRET, { :site => "http://twitter.com" })
      
      url = "http://localhost:3000/social_signup/twitter_users/signup?complete=1" #TODO: Hardcoded
      request_token = oauth.get_request_token(:oauth_callback => url)

      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret

      return redirect_to request_token.authorize_url
    end
    
    def create_user_incl_oauth_token
      oauth = OAuth::Consumer.new(TWITTER_KEY, TWITTER_SECRET, { :site => "http://twitter.com" })
      request_token = OAuth::RequestToken.new(oauth, session[:request_token], session[:request_token_secret])                                                                                        
      access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
      oauth = OAuth::Consumer.new(TWITTER_KEY, TWITTER_SECRET, { :site => "http://twitter.com" })

      response = oauth.request(:get, '/account/verify_credentials.json', access_token, { :scheme => :query_string })

      user_params = ActiveSupport::JSON.decode(response.body)
      user = ::User.new
      user.first_name = user_params["name"].split(' ').first
      user.last_name = user_params["name"].split(' ').last
      user.twitter_user_id = user_params["id"]
      user.twitter_oauth_token = access_token.token
      user.twitter_oauth_secret = access_token.secret

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
    end
    
  end
end  
