class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  #attr_accessible :firstname, :lastname, :username, :email, :password, :password_confirmation, :remember_me

  validates :firstname,
      :presence => true,
      :format => { :with => /\A[a-zA-Z]*\z/ }
  
  validates :lastname,
      :presence => true,
      :format => { :with => /\A[a-zA-Z]*\z/ }
  
  validates :username,
      :presence => true,
      :uniqueness => { :case_sensitive => false },
      :length => { :in => 4..20 },
      :format => { :with => /\A[a-zA-Z\d]*\z/ }
  
  validates :year_of_birth, :presence => true
  validates :gender, :presence => true

  validates_format_of :email, :with => Devise.email_regexp

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
          where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
          where(conditions).first
      end
  end      

  attr_accessor :login, :terms

  validates_acceptance_of :terms

  # Database relationship
  has_many :relaxation_sessions
end
