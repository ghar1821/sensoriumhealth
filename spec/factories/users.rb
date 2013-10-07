# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	firstname 'Test'
  	lastname 'user'
  	email 'userone@test.com'
  	year_of_birth 1990
  	gender "Male"
  	city "Sydney"
  	username 'testone'
  	password 'password'
  	password_confirmation 'password'
  	terms "1"
  	# Required for devise confirmable module to work
  	confirmed_at Time.now

  end
end
