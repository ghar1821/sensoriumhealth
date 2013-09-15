class User < ActiveRecord::Base
    validates :firstname,   presence: true
    validates :lastname,   presence: true
    validates :email,   presence: true
    validates :username,   presence: true
    validates :dob,   presence: true
    validates :gender,   presence: true
    validates :city,   presence: true
end
