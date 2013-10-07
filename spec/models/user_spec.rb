require 'spec_helper'

describe User do

	before(:each) do
		@attr = {
	    	:firstname => 'Test',
		  	:lastname => 'user',
		  	:email => 'userone@test.com',
		  	:year_of_birth => 1990,
		  	:gender => "Male",
		  	:city => "Sydney",
		  	:username => 'testone',
		  	:password => 'password',
		  	:password_confirmation => 'password',
		  	:terms => "1",
		  	:confirmed_at => Time.now
		}
	end
	
	it "should create a new instance given a valid attribute" do
		User.create!(@attr)
	end

	it "should require a firstname" do
		no_firstname_user = User.new(@attr.merge(:firstname => ""))
		no_firstname_user.should_not be_valid
	end

	it "should require a lastname" do
		no_lastname_user = User.new(@attr.merge(:lastname => ""))
		no_lastname_user.should_not be_valid
	end

	it "should require a username" do
		no_username_user = User.new(@attr.merge(:username => ""))
		no_username_user.should_not be_valid
	end

	it "should reject duplicate username" do
		User.create!(@attr)
		user_with_duplicate_username = User.new(@attr)
		user_with_duplicate_username.should_not be_valid
	end

	it "should require a year_of_birth" do
		no_username_year_of_birth = User.new(@attr.merge(:year_of_birth => ""))
		no_username_year_of_birth.should_not be_valid
	end

	it "should require a gender" do
		no_username_gender = User.new(@attr.merge(:gender => ""))
		no_username_gender.should_not be_valid
	end

	it "should accept terms of use and privacy policy" do
		no_terms_user = User.new(@attr.merge(:terms => 0))
		no_terms_user.should_not be_valid
	end

	it "should require an email address" do
		no_email_user = User.new(@attr.merge(:email => ""))
		no_email_user.should_not be_valid
	end

	it "should accept valid email addresses" do
		addresses = %w[userone@test.com THE_USER@foo.bar.org first.last@foo.jp]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
	end

	it "should reject invalid email addresses" do
		addresses = %w[userone@test,com user_at_foo.org example.user@foo.]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address))
			invalid_email_user.should_not be_valid
		end
	end

	it "should reject duplicate email addresses" do
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end

	it "should reject email addresses identical up to case" do
		upcased_email = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcased_email))
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end

	describe "passwords" do

		before(:each) do
			@user = User.new(@attr)
		end

		it "should have a password attribute" do
			@user.should respond_to(:password)
		end

		it "should have a password confirmation attribute" do
			@user.should respond_to(:password_confirmation)
		end
	end

	describe "password validations" do

		it "should require a password" do
			User.new(@attr.merge(:password => "", :password_confirmation => "")).
			should_not be_valid
		end

		it "should require a matching password confirmation" do
			User.new(@attr.merge(:password_confirmation => "invalid")).
		    should_not be_valid
		end

		it "should reject short passwords" do
			short = "a" * 5
			hash = @attr.merge(:password => short, :password_confirmation => short)
			User.new(hash).should_not be_valid
		end

	end

	describe "password encryption" do

		before(:each) do
			@user = User.create!(@attr)
		end

		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end

		it "should set the encrypted password attribute" do
			@user.encrypted_password.should_not be_blank
		end
	end
end
