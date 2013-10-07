require 'spec_helper'

describe StaticPagesController do 

	describe "Get 'home'" do
		it "should be successful" do
			get 'home'
			response.should be_success
		end
	end

	describe "Get 'help'" do
		it "should be successful" do
			get 'help'
			response.should be_success
		end
	end

	describe "Get 'about'" do
		it "should be successful" do
			get 'about'
			response.should be_success
		end
	end

	describe "Get 'contact'" do
		it "should be successful" do
			get 'contact'
			response.should be_success
		end
	end

	describe "Get 'terms of use'" do
		it "should be successful" do
			get 'terms'
			response.should be_success
		end
	end

	describe "Get 'privacy policy'" do
		it "should be successful" do
			get 'privacy'
			response.should be_success
		end
	end
end