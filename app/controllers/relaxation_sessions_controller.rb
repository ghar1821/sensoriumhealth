class RelaxationSessionsController < ApplicationController
    require 'fourier'
    require 'numbers'
    
    def index
        # Create new data. Data is an array of IBIs. This will be replaced this with data fetched from the real DB.
        @data = ::Numbers.get_data
        # Fast Fourier Transform of IBI data array
        @fft = ::Fourier.fft(@data)
        # Returns magnitude
        @yAxis = ::Fourier.to_magnitude(@fft)
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @xAxis}
            #format.json { render :json => @xAxis}
        end
    end
end