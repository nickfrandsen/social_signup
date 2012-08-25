class AddColumnsToUserModel < ActiveRecord::Migration
  def change
    add_column :social_signup_users, :facebook_user_id, :int
    add_column :social_signup_users, :facebook_oauth_token, :text
    add_column :social_signup_users, :twitter_user_id, :int
    add_column :social_signup_users, :twitter_oauth_token, :text
    add_column :social_signup_users, :twitter_oauth_secret, :text
  end
end
