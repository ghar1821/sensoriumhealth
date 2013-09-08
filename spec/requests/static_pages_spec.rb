require 'spec_helper'

describe "StaticPages" do

    # writting test for routes:
    # Home = root_path
    # Help = help_path
    # About = about_path
    # Contact = contact_path
    #
    # initial structure
    # it "shoud..." do
    #   visit root_path
    #   expect(page).to have_content(...)
    # end
    #
    # The bottom is the new form

    # this allow you to combine it "should.." do and expect(page) into
    # it {should have_content('...')
    subject {page}
    describe "Home page" do
        before { visit root_path }
        it { should have_title("BrightHearts | Home") }  
    end

    describe "Help page" do
        before { visit help_path }

        it { should have_title("BrightHearts | Help") }
        it { should have_content("FAQ") }
    end

    describe "About page" do
        before { visit about_path }

        it { should have_title("BrightHearts | About Us") }
        it { should have_content("About Us") }
    end

    describe "Contact page" do
        before { visit contact_path }

        it { should have_title("BrightHearts | Contact") }
        it { should have_content("Contact") }     
    end
end
