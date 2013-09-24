class RelaxationSessionsController < ApplicationController
    def index
        @xAxis = [1,2,3,4,5,6,7,8,9,10]
        @yAxis = [64,67,65,66,64,67,70,72,68,69]
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @xAxis}
            format.json { render :json => @xAxis}
        end
    end
end
