require "numbers" 
require "analysis"
require "lomb"
require 'nokogiri'

class IbiController < ApplicationController
	def index
        # Set threshold variables 
        @resonance_baseline = 50
        @resonance_line_width = 2
        
        # Display data from the relaxation_session table
        # Number of records needs to be >128
        # Currently, not linked to the database
        @mock_data = Numbers.get_data
        
        # Get data from data base (uncomment next two lines)
        # @data = Ibi.beatvalue
        # @analysis = Analysis.initialize(@data)
        
        # Iinitialise the "Analysis" class to perform all necessary analytics/ calculations.
        @analysis = Analysis.initialize(@mock_data)
        
        # All the information is ready at this stage.
        # Minimum heart rate in session.
        @min_heart_rate = Analysis.get_min_hr.round(2)
        # Maximum heart rate in session.
        @max_heart_rate = Analysis.get_max_hr.round(2)
        # Most common frequency in the session.
        @most_common_freq = Analysis.get_mcf.round(4)
        # Total time in resonance.
        @total_time_resonance = ((Analysis.get_ttr)/60).floor
        
        # LF = low frequency [0.04, 0.15)Hz.
		# A list of: percentage of LF power in each window/ time of each window.
		# The first window does NOT start at 0.
		# Power is the percentage of LF power relative to the total power.
		# This number should be [0, 1].
		# Time is the time of each window; time is defined as the time of
		# the last beat in that window. Time is in seconds.
		@power = Analysis.get_power
		@time = Analysis.get_time
		@total_time = ((@time.last)/60).floor
		@other_time = 6
    end

    
end
