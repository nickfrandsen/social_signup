require 'test_helper'

module SocialSignup
  class UsersControllerTest < ActionController::TestCase

    def setup
        @routes = SocialSignup::Engine.routes  
    end                                  
                                           
    test "should exist" do  
      get :new
    end
    # 
    # describe "failure" do
    # 
    #       before(:each) do
    #         @attr = { :name => "", :email => "", :password => "",
    #                   :password_confirmation => "" }
    #         @user = Factory.build(:user, @attr)
    #         User.stub!(:new).and_return(@user)
    #         @user.should_receive(:save).and_return(false)
    #       end
    # 
    #       it "should have the right title" do
    #         post :create, :user => @attr
    #         response.should have_tag("title", /sign up/i)
    #       end
    # 
    #       it "should render the 'new' page" do
    #         post :create, :user => @attr
    #         response.should render_template('new')
    #       end
    # end
    # 
    # describe "success" do
    # 
    #       before(:each) do
    #         @attr = { :name => "New User", :email => "user@example.com",
    #                   :password => "foobar", :password_confirmation => "foobar" }
    #         @user = Factory(:user, @attr)
    #         User.stub!(:new).and_return(@user)
    #         @user.should_receive(:save).and_return(true)
    #       end
    # 
    #       it "should redirect to the user show page" do
    #         post :create, :user => @attr
    #         response.should redirect_to(user_path(@user))
    #       end    
    # end

  end
end
