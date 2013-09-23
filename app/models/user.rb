class User < ActiveRecord::Base
    # downcasing the email and username attribute before being saved
    before_save { self.email = email.downcase } 
    before_save { self.username = username.downcase }

    # Callback method to create a remember token immediately before creating a
    # new user in the database.
    before_create :create_remember_token

    validates :firstname,   presence: true, length: { maximum: 30 }
    validates :lastname,   presence: true,  length: { maximum: 30 } 

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #enforce not blank, unique, and valid format (using regex above)
    validates :email,   presence: true, format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false } 
    validates :username,   presence: true,  length: { maximum: 30 },
        uniqueness: { case_sensitive: false }
    validates :year_of_birth,   presence: true
    validates :gender,   presence: true

    # Terms and conditions need to be accepted before registering
    validates :terms_and_conditions, presence: true

    # Client decision city do not need to be filled in.
    #    validates :city,   presence: true

    # Handles all the password and encrypted version of the password to save it as password_digest.
    # Encryption is a state-of-the-art has function called bcrypt
    has_secure_password
    validates :password, length: { minimum: 8 }

    validates_acceptance_of :terms_and_conditions
    # DATABASE RELATIONSHIP
    has_many :relaxation_sessions

    # Generating token for user.
    # Using string of length 16 using base64. 
    # With probability two remember token colliding be 1/(64^16) = 10^-29.
    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    # Encrypting the token using SHA1 hasing algorithm, much faster than bcrypt.
    # Speed is important SHA1 will be run on every page after user signed in.
    def User.encrypt(token)
        # call to_s is to make sure the app can handle nil tokens.
        Digest::SHA1.hexdigest(token.to_s)
    end

    private

        # Method reference arranges Rails to look for method called create_remember_token 
        # and run it before saving the user.
        # No need to expose this method outside users thus it's marked as private
        # so it is automatically hidden
        def create_remember_token
            # self keyword is important as without it, the assigment would create a local variable called remember_token.
            # self ensures the assignment sets the user's remember_token and written it to the database.
            self.remember_token = User.encrypt(User.new_remember_token)
        end

end
