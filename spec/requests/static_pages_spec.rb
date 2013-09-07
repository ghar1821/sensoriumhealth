require 'spec_helper'

describe "StaticPages" do

    describe "Home page" do
        it "should have the title 'BrightHearts | Home'" do
            visit '/static_pages/home'
            expect(page).to have_title("BrightHearts | Home")
        end
    end

    describe "Help page" do
        it "should have the title 'BrightHearts | Help'" do
            visit '/static_pages/help'
            expect(page).to have_title("BrightHearts | Help")
        end

        it "should have the content 'FAQ'" do
            visit '/static_pages/help'
            expect(page).to have_content('FAQ')
        end
    end

    describe "About page" do
        it "should have the title 'BrightHearts | About Us'" do
            visit '/static_pages/about'
            expect(page).to have_title("BrightHearts | About Us")
        end

        it "should have the content 'About Us'" do
            visit '/static_pages/about'
            expect(page).to have_content('About Us')
        end
    end


end
