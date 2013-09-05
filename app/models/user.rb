class User < ActiveRecord::Base
    has_many :useractivitys
    has_many :notifications
    has_and_belongs_to_many :challenges
    has_many :leaderboardentrys
end
