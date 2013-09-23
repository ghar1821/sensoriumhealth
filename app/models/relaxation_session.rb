class RelaxationSession < ActiveRecord::Base

    # DATABASE RELATIONSHIPS
    belongs_to :user
    has_many :session_heart_rates

end
