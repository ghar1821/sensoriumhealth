require 'spec_helper'

describe "UserPages" do

    subject { page }

    describe "profile page" do
        # Create a user factory using let command
        # and the FactoryGirl method supplied by Factory Girl ruby gems.
        let(:user) { FactoryGirl.create(:user) }
        before { visit user_path(user) }

        it { should have_content(user.name) }
        it { should have_title(user.name) }

    describe "signup page" do
        before { visit signup_path }

        it { should have_content('Sign up') }
        it { should have_title('BrightHearts | Sign up') }

    end
end
