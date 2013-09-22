require 'spec_helper'

describe "Authentication" do
    subject { page }
    describe "signin page" do
        before { visit signin_path }

        it { should have_content('Sign in') }
        it { should have_title('Sign in') }
    end

    describe "signin" do
        before { visit signin_path }
   
        # Sigin failure.
        describe "with invalid information" do
            before { click_button "Sign in" }

            it { should have_title('Sign in') }
            it { should have_selector('div.alert.alert-error', text: 'Invalid') }

            # This is so that the error message do not get relayed to any other pages when user failed to sign in
            describe "after visiting another page" do
                before { visit root_path  }
                it { should_not have_selector('div.alert.alert-error') }
            end
        end

        # Sigin successful
        describe "with valid information" do
            let(:user) { FactoryGirl.create(:user) }
            before do
                fill_in "Username",     with: user.username.downcase
                fill_in "Password",     with: user.password
                click_button "Sign in"
            end

            it { should have_title(user.username) }
            it { should have_link('Profile',    href: user_path(user)) }   
            it { should have_link('Sign out',  href: signout_path) }
            it { should_not have_link('Sign in',   href: signin_path) }

            # Test for signout (straight away after signin)
            describe "followed by signout" do
                before { click_link "Sign out" }
                it { should have_link('Sign in') }
            end

        end
    end
end
