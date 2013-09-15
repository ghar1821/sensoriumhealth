class User < ActiveRecord::Base
    validates :firstname,   presence: true, length: { maximum: 30 }
    validates :lastname,   presence: true,  length: { maximum: 30 }    
    validates :email,   presence: true
    validates :username,   presence: true,  length: { maximum: 30 }
    validates :dob,   presence: true
    validates :gender,   presence: true
    validates :city,   presence: true
end
