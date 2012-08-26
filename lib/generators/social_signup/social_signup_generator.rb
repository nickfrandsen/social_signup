module SocialSignup
  module Generators
    class SocialSignupGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      namespace "social_signup"
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a model with the given NAME (if one does not exist) with social_signup " <<
           "configuration plus a migration file and social_signup routes."

      hook_for :orm

      class_option :routes, :desc => "Generate routes", :type => :boolean, :default => true

      def add_social_signup_routes
        route 'mount SocialSignup::Engine => "/social_signup"'
      end
    end
  end
end
