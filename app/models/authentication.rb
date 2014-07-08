class Authentication < ActiveRecord::Base

	require 'bcrypt'
	 attr_accessor :password
  before_save :encrypt_password
  
  # validates_confirmation_of :password
  # validates_presence_of :password, :on => :create
  # validates_presence_of :email
  # validates_uniqueness_of :email
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
    end
  end


def self.authenticate(email, password)
  user = Authentication.find_by_email(email)
  user 
   	if user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    	user
    
    else
        nil
    end
 end


end
