require 'spec_helper'

describe User do
    before do
    # before block creates new @user instance variable using User.new
    # and a valid initialisation hash.
        @user = User.new(firstname: "Example firstname", 
                              lastname: "Example lastname", 
                              email: "user@example.com", 
                              username: "Example username",
                              dob: "01/01/2000",
                              gender: "1",
                              city: "Examplecity",
                              password: "foobarrrr",
                              password_confirmation: "foobarrrr"
                             )
    end

    # make @user the default subject of the test example
    subject { @user }

    # method below using Ruby method respond_to? accept symbol and returns true
    # if the object responds to the attributes and false otherwise.
    # can be tested using rails console --sandbox
    # user = User.new
    # user.respond_to?(:name) => true
    # user.respond_to?(:blah) => false (field doesn't even exists)
    # make sure each field is filled.
    #
    # RSpec code equivalent:
    # it "should respond to 'firstname'" do
    #   expect(@user).to respond_to(:firstname)
    # end
    #
    # Need to update app/models/user.rb file as well for it to work
    # validates :firstname, presence: true
    # 
    # Password digest is the password user need to put in.
    # The attribute name has to be password_digest for bcrypt to work.
    it { should respond_to(:firstname) }
    it { should respond_to(:lastname) }
    it { should respond_to(:email) }
    it { should respond_to(:username) }
    it { should respond_to(:dob) }
    it { should respond_to(:gender) }
    it { should respond_to(:city) }
    it { should respond_to(:password_digest) }

    # This fields are used to make users confirm their passwords to minimise typos.
    # This attributes are only virtual (only exist temporarily in memory)
    # Remember to add both fields to the initialisation hash for User.new at the top.
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

    # requiring user object to respond to authenticate
    it { should respond_to(:authenticate) }

    # sanity check, verifying @user is initially valid
    # this is 1 line version of
    # it "should be valid" do
    #   expect(@user).to be_valid
    # end
    it { should be_valid }

    # the test set the user's firstname to blank value,
    # then tests to see that the resulting @user object is invalid.
    describe "when firstname is not present" do
        before { @user.firstname = " " }
        it { should_not be_valid }
    end

    describe "when lastname is not present" do
        before { @user.lastname = " " }
        it { should_not be_valid }
    end

   describe "when email is not present" do
        before { @user.email = " " }
        it { should_not be_valid }
    end

    describe "when username is not present" do
        before { @user.username = " " }
        it { should_not be_valid }
    end

   describe "when dob is not present" do
        before { @user.dob = " " }
        it { should_not be_valid }
    end

    describe "when gender is not present" do
        before { @user.gender = " " }
        it { should_not be_valid }
    end

   describe "when password is not present" do
       before do
           @user = User.new(firstname: "Example firstname", 
                              lastname: "Example lastname", 
                              email: "user@example.com", 
                              username: "Example username",
                              dob: "01/01/2000",
                              gender: "1",
                              city: "Examplecity",
                              password: " ",
                              password_confirmation: " ")
       end
       it { should_not be_valid }
   end

   # enforcing limit to some of the field
   # Using string manipulation, make a string of 30 characters long
   #
   # Need to incorporate validates :firstname, length: { maximum: 30 } in app/models/user.rb
   describe "when firstname is too long" do
       before { @user.firstname = "a" * 31 }
       it { should_not be_valid }
   end

    describe "when lastname is too long" do
       before { @user.lastname = "a" * 31 }
       it { should_not be_valid }
   end

    describe "when username is too long" do
       before { @user.username = "a" * 31 }
       it { should_not be_valid }
   end

    # check for email address format
    # when the format is invalid (each separated by space)
    #
    # Need to incorporate VALID_EMAIL_REGEX (valid email format with @ and . expressed in Regex).
    # and validates :email, format: { with: VALID_EMAIL_REGEX }
    describe "when email format is invalid" do
        it "shoud be invalid" do
            addresses = %w[example@blah,com 
                user_at_b.org 
                example.user@foo. 
                foo@fd_fd.com 
                foo@bar+bar.com]
            addresses.each do |invalid_address|
                @user.email = invalid_address
                expect(@user).not_to be_valid
            end
        end
    end

    # valid email address
    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.COM 
                EXAMPLE_EG-EG@f.b.org 
                first.last@email.au 
                a+b@baz.co]
            addresses.each do |valid_address|
                @user.email = valid_address
                expect(@user).to be_valid
            end
        end
    end

    # check for duplicate email address
    # make a user with the same email address as @user using @user.dup.
    # @user.dup creates a duplicate user with the same attributes.
    # Since it is then saved, the original @user has an email address that 
    # already exists in the database, and hence should not be valid.i
    # email should also be case insensitive
    #
    # Need to add validates :email uniqueness: { case_sensitive: false } for it to work.
    describe "when email address is already taken" do
        before do
            user_with_same_email = @user.dup
            user_with_same_email.email = @user.email.upcase
            user_with_same_email.save
        end
        
        it { should_not be_valid }
    end

    # check for duplicate username
    describe "when username is already taken" do
        before do
            user_with_same_username = @user.dup
            user_with_same_username.username = @user.username.upcase
            user_with_same_username.save
        end

        it { should_not be_valid }
    end

    # checking for password mismatch
    describe "when password doesn't match confirmation" do
        before { @user.password_confirmation = "mismatch" }
        it { should_not be_valid }
    end

    # security precaution, test for length validation on passwords.
    # It need to be at least 8 characters long
    describe "with a password that's too short" do
        before { @user.password = @user.password_confirmation = "a" * 7 }
        it { should be_invalid }
    end

    # During authentication cases for password match and mismatch
    describe "return value of authenticate method" do
        # saves the user to database so it can be retrieved using find_by.
        before { @user.save }
        # find_by is accomplished using let method:
        # let create local variables inside tests. Its syntax says:
        # creates a found_user variable whose value is equal to the result
        # of find_by.
        # This variable can be used in any of the before or it blocks
        # throughout the rest of the test.
        let(:found_user) { User.find_by(username: @user.username) }

        # @user and found_user is the same (password match)
        # using "equals" eq test for object equality
        describe "with valid password" do
            it { should eq found_user.authenticate(@user.password) }
        end

        # specify is a synonym for it.
        # It can be used when writing it would sound unnatural.
        describe "with invalid password" do
            # this let do not hit the database a second time!
            let(:user_for_invalid_password) { found_user.authenticate("invalid") }
            it { should_not eq user_for_invalid_password }
            specify { expect(user_for_invalid_password).to be_false }
        end
    end


end
