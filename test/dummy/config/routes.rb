Rails.application.routes.draw do

  social_signup_for :member_threes

  mount SocialSignup::Engine => "/social_signup"
end
