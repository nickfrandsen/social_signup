require 'rails/generators/active_record'
require 'generators/social_signup/orm_helpers'

module ActiveRecord
  module Generators
    class SocialSignupGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      include SocialSignup::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def copy_social_signup_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template "migration_existing.rb", "db/migrate/add_social_signup_to_#{table_name}"
        else
          migration_template "migration.rb", "db/migrate/social_signup_create_#{table_name}"
        end
      end

      def generate_model
        invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end

      def inject_social_signup_content
        content = model_contents + <<CONTENT
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
CONTENT

        class_path = class_name.to_s.split("::")

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"

        inject_into_class(model_path, class_path.last, content) if model_exists?
      end

      def migration_data
<<RUBY
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token
RUBY
      end
    end
  end
end
