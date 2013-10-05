class SessionHeartRatesController < ApplicationController
    def index
        # Display data from the relaxation_session table
        @session_heart_rate = SessionHeartRate.find(:all, :limit => 100)
        #@session_heart_rate = SessionHeartRate.all
    end
end
