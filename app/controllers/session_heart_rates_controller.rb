require "numbers" 
require "analysis"
require "lomb"

class SessionHeartRatesController < ApplicationController
    def index
        # Display data from the relaxation_session table
        @session_heart_rate = SessionHeartRate.all
        @mock_data = Numbers.get_data
        
        # Iinitialise the "Analysis" class to perform all necessary analytics/ calculations.
        @analysis = Analysis.initialize(@mock_data)
        
        # All the information is ready at this stage.
        # Minimum heart rate in session.
        @min_heart_rate = Analysis.get_min_hr.to_s
        # Maximum heart rate in session.
        @max_heart_rate = Analysis.get_max_hr.to_s
        # Most common frequency in the session.
        @most_common_freq = Analysis.get_mcf.to_s
        # Total time in resonance.
        @total_time_resonance = Analysis.get_ttr.to_s
        
        # LF = low frequency [0.04, 0.15)Hz.
		# A list of: percentage of LF power in each window/ time of each window.
		# The first window does NOT start at 0.
		# Power is the percentage of LF power relative to the total power.
		# This number should be [0, 1].
		# Time is the time of each window; time is defined as the time of
		# the last beat in that window. Time is in seconds.
		@yAxis = []
		@length = Analysis.get_power.length
		@power = Analysis.get_power
		@time = Analysis.get_time
		#for i in (0...Analysis.get_power.length)
		#	@power = Analysis.get_power[i].to_s
		#	@time = Analysis.get_time[i].to_s
		#end
    end
end
