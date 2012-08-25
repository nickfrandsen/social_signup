module SocialSignup
  class Engine < ::Rails::Engine
    isolate_namespace SocialSignup
    require 'rubygems'
    require 'bcrypt'
  end
end
