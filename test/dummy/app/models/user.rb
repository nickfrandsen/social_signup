class User < ActiveRecord::Base
    # Injected from social signup gem
        attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
        attr_accessor :password
        before_save :encrypt_password

        #TODO: Need to validate attributes
        validates_confirmation_of :password
        #validates_presence_of :password, :on => :create
        #validates_presence_of :email
        #validates_uniqueness_of :email

        def self.authenticate(email, password)
          user = find_by_email(email)
          if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
            user
          else
            nil
          end
        end

        def encrypt_password
          if password.present?
            self.password_salt = BCrypt::Engine.generate_salt
            self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
          end
        end
  # attr_accessible :title, :body
end