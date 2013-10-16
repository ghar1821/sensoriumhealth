require "numbers" 
require "analysis"
require "lomb"

class SessionHeartRatesController < ApplicationController
    def index
        # Display data from the relaxation_session table
        @session_heart_rate = SessionHeartRate.all
        @mock_data = Numbers.get_data
        
        @analysis = Analysis.initialize(@mock_data)
    end
end
