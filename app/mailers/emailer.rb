class Emailer < ActionMailer::Base
  default from: "admin@sensoriumhealth.com"

  attr_accessor :body

  headers = {'Return-Path' => 'contact@sensoriumhealth.com'}

  def send_email(user_info)
  	@user_info = user_info
    @users = User.all

    @users.each do |user|
	    mail(
	      to: user.email,
	      subject: "BrightHearts notification",
	      from: "BrightHearts <admin@sensoriumhealth.com>",
	      return_path: "contact@sensoriumhealth.com",
	      date: Time.now,
	      content_type: "text/html"
	    )
	end
  end
end
