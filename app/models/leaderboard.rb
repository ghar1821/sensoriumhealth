class Leaderboard < ActiveRecord::Base
    belongs_to :challenge
    has_many :leaderboardentrys
end
