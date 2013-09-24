class RelaxationSessionsController < ApplicationController
    require 'fourier'
    require 'numbers'
   
   def index
        # Create new data. Data is an array of IBIs. This will be replaced this with data
        # fetched from the real DB.
        @data = ::Numbers.get_data
        #s.Fourier.sample.new(@data)
        
        #@yAxis = Fourier.sample.new(@data).Fourier.get_magnitude
        #@xAxis = []
        #for i in (0..127) do
        #    x << i*0.8/128
        #end
        
        @xAxis = [1,2,3]
        @yAxis = [60,65,63]
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @xAxis}
            format.json { render :json => @xAxis}
        end
    end
end
