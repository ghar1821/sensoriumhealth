### UTILITY METHODS ###

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

def create_invalid_yob_visitor
  @visitor ||= { :firstname => 'Test',
                  :lastname => 'two',
                  :email => 'usertwo@test.com',
                  :gender => "Male",
                  :city => "Sydney",
                  :username => 'test',
                  :password => 'password',
                  :password_confirmation => 'password',
                  :terms => "1",
                 
                }
end

####### Relaxation session #########
def create_session_details
  @session ||= {
    :device_id => 'B6F3384B-E816-4C4D-6FA8-465226DF6D1E',
    :username => 'test',
    :timezone => '+1000',
    :session_start_time => "06:43:15.2",
    :session_start_date => "2013-05-18",
    :session_end_time => "06:43:25.2",
    :session_end_date => "2013-05-18",
  }
end

def create_session
  create_session_details
  
  @session = FactoryGirl.create(:relaxation_session, @session)
end


####### ################## #########

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
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

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_firstname", :with => @visitor[:firstname]
  fill_in "user_lastname", :with => @visitor[:lastname]
  fill_in "user_username", :with => @visitor[:username]
  select(@visitor[:year_of_birth], :from => "Year of birth")
  choose @visitor[:gender]
  select(@visitor[:city], :from => "user_city") 
  check("Accept")
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_up_invalid_gender
  delete_user
  visit '/users/sign_up'
  fill_in "user_firstname", :with => @visitor[:firstname]
  fill_in "user_lastname", :with => @visitor[:lastname]
  fill_in "user_username", :with => @visitor[:username]
  select(@visitor[:year_of_birth], :from => "Year of birth")
  select(@visitor[:city], :from => "user_city") 
  check("Accept")
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_up_untick_terms
  delete_user
  visit '/users/sign_up'
  fill_in "user_firstname", :with => @visitor[:firstname]
  fill_in "user_lastname", :with => @visitor[:lastname]
  fill_in "user_username", :with => @visitor[:username]
  select(@visitor[:year_of_birth], :from => "Year of birth")
  choose @visitor[:gender]
  select(@visitor[:city], :from => "user_city") 
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "Username or email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

def sign_in_with_username
  visit '/users/sign_in'
  fill_in "Username or email", :with => @visitor[:username]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

Given /^I have a relaxation session$/ do
  create_session
end

### WHEN ###

When /^I check my relaxation session$/ do
  first(:link, "Relaxation session").click
  # click_link "Relaxation session"
end

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

# Test for invalid emails #
When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up with a blank email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "")
  sign_up
end

# Test for invalid username #
When /^I sign up with a blank username$/ do
  create_visitor
  @visitor = @visitor.merge(:username => "")
  sign_up
end

When /^I sign up with an invalid username$/ do
  create_visitor
  @visitor = @visitor.merge(:username => "!@!@!@!@")
  sign_up
end

When /^I sign up with username that is too short$/ do
  create_visitor
  @visitor = @visitor.merge(:username => "as")
  sign_up
end

# Test for invalid password #
When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a password that is too short$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "asdf")
   @visitor = @visitor.merge(:password_confirmation => "asdf")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

# Test for invalid firstname # 
When /^I sign up without a firstname$/ do
  create_visitor
  @visitor = @visitor.merge(:firstname => "")
  sign_up
end

When /^I sign up with an invalid firstname$/ do
  create_visitor
  @visitor = @visitor.merge(:firstname => "blah1234")
  sign_up
end

# Test for invalid lastname # 
When /^I sign up without a lastname$/ do
  create_visitor
  @visitor = @visitor.merge(:lastname => "")
  sign_up
end

When /^I sign up with an invalid lastname$/ do
  create_visitor
  @visitor = @visitor.merge(:lastname => "blah1234")
  sign_up
end

# Test without year of birth #
When /^I sign up without year of birth$/ do
  create_invalid_yob_visitor
  sign_up
end

# Test without gender #
When /^I sign up without gender$/ do
  create_visitor
  sign_up_invalid_gender
end

# Test untick terms #
When /^I sign up without accepting terms of use and privacy policy$/ do
  create_visitor
  sign_up_untick_terms
end



When /^I return to the site$/ do
  visit '/'
end

# Test for sign in #
When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong username$/ do
  @visitor = @visitor.merge(:username => "wrong")
  sign_in_with_username
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

# Test for editting account #
When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_password", :with => "newnamee"
  fill_in "user_password_confirmation", :with => "newnamee"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I edit my account details with wrong current password$/ do
  click_link "Edit account"
  fill_in "user_password", :with => "newnamee"
  fill_in "user_password_confirmation", :with => "newnamee"
  fill_in "user_current_password", :with => "asdfasdfasdfasdf"
  click_button "Update"
end

When /^I edit my account details without filling in current password$/ do
  click_link "Edit account"
  fill_in "user_password", :with => "newnamee"
  fill_in "user_password_confirmation", :with => "newnamee"
  click_button "Update"
end

When /^I edit my account details with mismatched password$/ do
  click_link "Edit account"
  fill_in "user_password", :with => "newnamee"
  fill_in "user_password_confirmation", :with => "newnameeeeee"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I cancel my account$/ do
  click_link "Edit account"
  click_link "Cancel my account"
end

When /^I look at the list of users$/ do
  visit '/'
end

When /^I look at my profile$/ do
  click_link "Profile"
end

# CHECK LEADERBOARD #
When /^I look at the leaderboard$/ do
  click_link "Leaderboard"
end


#########################################################################################################
### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "A message with a confirmation link has been sent to your email address"
end

# Invalid email message #
Then /^I should see an invalid email message$/ do
  page.should have_content "Emailis invalid"
end

Then /^I should see a blank email message$/ do
  page.should have_content "Emailcan't be blank"
end

# Invalid username #
Then /^I should see an invalid username message$/ do
  page.should have_content "Usernameis invalid"
end

Then /^I should see a blank username message$/ do
  page.should have_content "Usernamecan't be blank"
end

Then /^I should see a short username message$/ do
  page.should have_content "Usernameis too short"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Passwordcan't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password confirmationdoesn't match Password"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password confirmationdoesn't match Password"
end

Then /^I should see a short password message$/ do
  page.should have_content "Passwordis too short"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my username$/ do
  create_user
  page.should have_content @user[:username]
end

Then /^show me the page$/ do
  save_and_open_page
end

# Invalid firstname message #
Then /^I should see a missing firstname message$/ do
  page.should have_content "Firstnamecan't be blank"
end

Then /^I should see an invalid firstname message$/ do
  page.should have_content "Firstnameis invalid"
end

# Invalid lastname message #
Then /^I should see a missing lastname message$/ do
  page.should have_content "Lastnamecan't be blank"
end

Then /^I should see an invalid lastname message$/ do
  page.should have_content "Lastnameis invalid"
end

# Blank year of birth message #
Then /^I should see a blank year of birth message$/ do
  page.should have_content "Year of birth19331934193519361937193819391940194119421943194419451946194719481949195019511952195319541955195619571958195919601961196219631964196519661967196819691970197119721973197419751976197719781979198019811982198319841985198619871988198919901991199219931994199519961997199819992000can't be blank"
end

# Blank year of birth message #
Then /^I should see a blank gender message$/ do
  page.should have_content "GenderMaleFemalecan't be blank"
end

# Blank privacy policy and terms of use message #
Then /^I should see a blank terms and policy message$/ do
  page.should have_content "Accept Terms of use and privacy Policy must be accepted"
end

# Edit account errors #
Then /^I should see edit profile blank current password message$/ do
  page.should have_content "Current passwordcan't be blank"
end

Then /^I should see edit profile invalid current password message$/ do
  page.should have_content "Current passwordis invalid"
end

Then /^I should see edit profile password mismatched message$/ do
  page.should have_content "Password confirmationdoesn't match Password"
end

Then /^I should see a successful cancel account message$/ do
  page.should have_content "Bye! Your account was successfully cancelled. We hope to see you again soon."
end

# CHECK LEADERBOARD #
Then /^I should see the leaderboard heading$/ do
  page.should have_content "Leaderboard"
end

Then /^I should see my username table entry$/ do
  page.should have_content @visitor[:username]
end

Then /^I should see the longest time in resonance heading$/ do
  page.should have_content "Longest time in resonance"
end

Then /^I should see the entry is 00:00:00$/ do
  page.should have_content "00:00:00"
end

Then /^I should see the table heading$/ do
  page.should have_content "Relaxation sessions   Device ID   Session start date  Session start time  Session end date  Session end time"
end

Then /^I should see my relaxation session device entry$/ do
  page.should have_content @session[:device_id]   
end

Then /^I should see my relaxation session start time entry$/ do
  page.should have_content @session[:session_start_time]   
end

Then /^I should see my relaxation session start date entry$/ do
  page.should have_content @session[:session_start_date]   
end

Then /^I should see my relaxation session ending time entry$/ do
  page.should have_content @session[:session_end_time]   
end

Then /^I should see my relaxation session ending date entry$/ do
  page.should have_content @session[:session_end_date]   
end