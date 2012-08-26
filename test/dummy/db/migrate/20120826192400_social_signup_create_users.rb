class SocialSignupCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_hash
      t.string :password_salt

      t.integer :facebook_user_id
      t.string :facebook_oauth_token
      t.integer :twitter_user_id
      t.string :twitter_oauth_token
      t.string :twitter_oauth_secret

      t.timestamps



      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end
