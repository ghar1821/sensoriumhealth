def create_visitor
  @visitor ||= { :firstname => 'Test',
                  :lastname => 'two',
                  :email => 'usertwo@test.com',
                  :year_of_birth => 1990,
                  :gender => "Male",
                  :city => "Sydney",
                  :username => 'test',
                  :password => 'password',
                  :password_confirmation => 'password',
                  :terms => "1",
                 
                }
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end
def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end
########## Admin account ###########
def create_admin_details
  @admin_details ||= {
    :email => 'admin@admin.com',
    :password => 'password',
    :username => 'admin',
  }
end

def delete_admin
  @admin ||= Admin.where(:email => @admin_details[:email]).first
  @admin.destroy unless @admin.nil?
end


def create_admin
  create_admin_details
  delete_admin
  @admin = FactoryGirl.create(:admin, @admin_details)
end

def sign_in_as_admin
  visit '/admins/sign_in'
  fill_in "Username or email", :with => @admin_details[:email]
  fill_in "Password", :with => @admin_details[:password]
  click_button "Sign in"
end

def sign_in_as_admin_username
  visit '/admins/sign_in'
  fill_in "Username or email", :with => @admin_details[:username]
  fill_in "Password", :with => @admin_details[:password]
  click_button "Sign in"
end


########## ################## ##########

### GIVEN ###
Given /^I am logged in as admin$/ do
  create_admin
  sign_in_as_admin
end

Given /^I exist as an admin$/ do
  create_user
  create_admin
end

Given /^I do not exist as an admin$/ do
  create_admin_details
  delete_admin
end

### WHEN ###
########## Admin account ################
When /^I sign in with valid admin data$/ do
  create_admin_details
  sign_in_as_admin
end

When /^I sign in with valid admin username$/ do
  create_admin_details
  sign_in_as_admin_username
end

When /^I sign in with an invalid admin email$/ do
  create_admin_details
  @admin_details = @admin_details.merge(:email => "not@anemail.com")
  sign_in_as_admin
end

When /^I sign in with an invalid admin username$/ do
  @admin_details = @admin_details.merge(:username => "wrong")
  sign_in_as_admin_username
end

When /^I sign in with an invalid admin password$/ do
  @admin_details = @admin_details.merge(:password => "wrongpass")
  sign_in_as_admin
end

### THEN ###
Then /^I see a successful admin sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I admin should be signed in$/ do
  page.should have_content "Logout"
  page.should have_content "Username"
  page.should have_content "Email"
  page.should have_content "Gender"
  page.should have_content "City"
  page.should have_content "Last sign in"
  page.should have_content "Send email"
  page.should have_content "Parse XML"

  ### USER DETAILS ####
  page.should have_content @user[:username]
  page.should have_content @user[:email]
  page.should have_content @user[:gender]
  page.should have_content @user[:city]
  page.should have_content @user[:last_sign_in_at]
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"

end

Then /^I see an invalid admin login message$/ do
  page.should have_content "Invalid email or password."
end