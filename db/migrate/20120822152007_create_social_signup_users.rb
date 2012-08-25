class CreateSocialSignupUsers < ActiveRecord::Migration
  def change
    create_table :social_signup_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
