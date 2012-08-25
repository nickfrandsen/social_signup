SocialSignup::Engine.routes.draw do
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :sessions
  resources :users
  resources :facebook_users do
    collection do
      get 'signup'
    end
  end
  resources :twitter_users do
    collection do
      get 'signup'
    end
  end

  root :to => "public#index"
end