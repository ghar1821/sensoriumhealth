class RelaxationSession < ActiveRecord::Base

	# Database relationship
	belongs_to :user
	has_many :ibis, dependent: :destroy
	has_many :statuses, dependent: :destroy
end
