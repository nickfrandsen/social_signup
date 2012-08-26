Rails.application.routes.draw do

  social_signup_for :users

  mount SocialSignup::Engine => "/social_signup"
end
