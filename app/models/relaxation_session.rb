class RelaxationSession < ActiveRecord::Base

	# Database relationship
	belongs_to :user
	has_many :ibis
	has_many :statuses
end
