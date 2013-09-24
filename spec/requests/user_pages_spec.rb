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
                fill_in "Firstname",        with: "foo"
                fill_in "Lastname",         with: "baz"
                fill_in "Username",         with: "foobaz"
                fill_in "Email",            with: "foo.baz@baz.com"
                choose "Male"
                select('1990', :from => 'Year of birth')
                fill_in "City",             with: "Sydney"
                fill_in "Password *",         with: "foobazbaz"
                fill_in "Confirmation",with: "foobazbaz"
                check ("Terms")

            end

            it "should create a user" do
                expect { click_button submit }.to change(User, :count).by(1)
            end

            # test to ensure user is signed in right after they register
            describe "after saving the user" do
                before { click_button submit }
                let(:user) { User.find_by(username: 'foobaz') }

                it { should have_link('Sign out') }
                it { should have_title(user.username) }
                it { should have_selector('div.alert.alert-success', text: 'Welcome') }
            end

        end
        
    end
end
