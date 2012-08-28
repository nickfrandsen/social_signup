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
    end

    add_index :users, :email,                :unique => true
  end
end
