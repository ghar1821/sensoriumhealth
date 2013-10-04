class SessionHeartRatesController < ApplicationController
    def index
        # Display data from the relaxation_session table
        @session_heart_rate = SessionHeartRate.all
    end
end
