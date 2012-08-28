require_dependency "social_signup/application_controller"

module SocialSignup
  class UsersController < ApplicationController
        
    def index
      @users = ::User.all
    end
    
    def new
      @user = ::User.new
    end
    
    def create
      user = ::User.new(params[:user])
      if user.save
        redirect_to root_path, :notice => "Thank you for signing up!"
      else
        render "new"
      end
    end
    
    def edit
      @user = current_user
    end
    
    def update
      @user = current_user
      if @user.update_attributes(params[:user])
        redirect_to root_path, :notice => "Changes have been added"
      else 
        render :action => 'edit'
      end
    end
    
  end
end
