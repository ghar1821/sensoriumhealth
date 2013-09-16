class User < ActiveRecord::Base
    # downcasing the email and username attribute before being saved
    before_save { self.email = email.downcase } 
    before_save { self.username = username.downcase }
    validates :firstname,   presence: true, length: { maximum: 30 }
    validates :lastname,   presence: true,  length: { maximum: 30 } 

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #enforce not blank, unique, and valid format (using regex above)
    validates :email,   presence: true, format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false } 
    validates :username,   presence: true,  length: { maximum: 30 },
        uniqueness: { case_sensitive: false }
    validates :dob,   presence: true
    validates :gender,   presence: true
    # Client decision city do not need to be filled in.
    #    validates :city,   presence: true

    # Gets all the current password tests to pass.
    # Need to be commented out so as to prevent some test from being red before going green
    has_secure_password
end
