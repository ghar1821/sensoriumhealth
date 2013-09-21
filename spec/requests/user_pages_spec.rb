require 'spec_helper'

describe "UserPages" do

    subject { page }

    describe "profile page" do
        # Create a user factory using let command
        # and the FactoryGirl method supplied by Factory Girl ruby gems.
        let(:user) { FactoryGirl.create(:user) }
        before { visit user_path(user) }

        it { should have_content(user.username) }
        it { should have_title(user.username) }
    end

    describe "signup page" do
        before { visit signup_path }

        it { should have_content('Sign up') }
        it { should have_title('BrightHearts | Sign up') }

    end

    describe "signup" do
        before { visit signup_path }

        let(:submit) { "Create my account" }

        # Submitting blank form is not allowed.
        describe "with invalid information" do
            it "should not create a user" do
                # Clicking the submit button results in invalid behavior,
                # a.k.a not creating user.
                # It's done by checking the count of users.
                # the :count method is available for Active Record class.
                # The line below calculates User.count before and after
                # the execution of click_button submit.
                expect { click_button submit }.not_to change(User, :count)
            end

            before { click_button submit }

            it { should have_title('Sign up') }
            it { should have_content('error') }
    
        end

        # Submitting form with all fields filled is allowed.
        describe "with valid information" do
            before do
                # Fill_in is simulating filling in valid information.
                fill_in "Firstname",        with: "User"
                fill_in "Lastname",         with: "One"
                fill_in "Username",         with: "UserOne"
                fill_in "Email",            with: "User.one@example.com"
                choose "Female"
                fill_in "Year of birth",    with: 1990
                fill_in "City",             with: "Sydney"
                fill_in "Password",         with: "123456789"
                fill_in "Confirmation",with: "123456789"
                check ('Terms')
            end

            it "should create a user" do
                expect { click_button submit }.to change(User, :count).by(1)
            end

        end
        
    end
end
