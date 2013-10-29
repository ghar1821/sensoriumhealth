class EmailerController < ApplicationController
	before_filter :authenticate_admin!

	# Showing the email form
	def contact
	end

	# Sending email to all user.
	# @params user_info is the content of the message
	def dispatch_email
		user_info = params[:user_info]
    	if Emailer.send_email(user_info).deliver
	      flash[:notice] = "Sent!"
	    else
	      flash[:notice] = "Could't send you message."
	    end
	    redirect_to contact_url
	end
end
