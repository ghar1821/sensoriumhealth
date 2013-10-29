require 'nokogiri'
class AdminController < ApplicationController
before_filter :authenticate_admin!

	# Admin dashboard, showing all users
	def show
		@users = User.all
	end

	# Function to parse offline xml stored in data folder.
	# Using nokogiri gem.
	# Please search nokogiri documentation on google to learn how it works.
	def parse_xml

		filename = File.join(Rails.root, 'data', 'sampleSession.xml')
		f = File.open(filename)
		@doc = Nokogiri::XML(f)

		session_start = @doc.css('session_start').children
		session_end = @doc.css('session_end').children
		device_session = @doc.css('devicesession').children

		session = RelaxationSession.new
		session.device_id = device_session.css('dev_id').inner_text
		session.username = device_session.css('username').inner_text
		session.timezone = device_session.css('timezone').inner_text
		session.session_start_date = session_start.css('date').inner_text
		session.session_start_time = session_start.css('time').inner_text
		session.session_end_date = session_end.css('date').inner_text
		session.session_end_time = session_end.css('time').inner_text
		
		session.save

		@doc.css('beat').each do |node|
	        children = node.children

	        ibi = session.ibis.create(
	        	:beat_count => children.css('count').inner_text,
	        	:beat_time => children.css('timestamp').inner_text,
	        	:beat_value => children.css('value').inner_text)
	    end

	    @doc.css('sensor_reliability').each do |node|
	        children = node.children

	        status = session.statuses.create(
	        	:sensor_reliability_value => children.css('value').inner_text,
	        	:sensor_reliability_time => children.css('timestamp').inner_text)
	    end

		f.close
		
	end
end
