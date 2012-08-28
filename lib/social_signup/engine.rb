module SocialSignup
  class Engine < ::Rails::Engine
    isolate_namespace SocialSignup
    require 'rubygems'
    require 'bcrypt'
    require 'oauth'
    require 'social_signup/facebook'
    require 'social_signup/twitter'
  end
end
