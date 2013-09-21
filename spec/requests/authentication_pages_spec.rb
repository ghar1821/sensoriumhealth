require 'spec_helper'

describe "Authentication" do
    subject { page }
    describe "signin page" do
        before { visit signin_path }

        it { should have_content('Sign in') }
        it { should have_title('Sign in') }
    end

    desribe "signin" do
        before { visit signin_path }
   
        # Sigin failure.
        describe "with invalid information" do
            before { click_button "Sign in" }

            it { should have_title('Sign in') }
            it { should have_selector('div.alert.alert-error', text: 'Invalid') }
        end

        # Sigin successful
        describe "with valid information" do
            let(:user) { FactoryGirl.create(:user) }
            before do
                fill_in "Username",     with: user.username
                fill_in "Password",     with: user.password
                click_button "Sign in"
            end

            it { should have_title(user.username) }
            it { should have_link('Profile',    href: user_path(user)) }   
            it { should have_link('Sign out',  href: signout_path) }
            it { should_not have_link('Sign in',   href: signin_path) }    
        end
    end
end
