# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relaxation_session do
    device_id "MyString"
    username "MyString"
    timezone "MyString"
    session_start_time "2013-10-05 12:04:44"
    session_start_date "2013-10-05"
    session_end_time "2013-10-05 12:04:44"
    session_end_date "2013-10-05"
  end
end
