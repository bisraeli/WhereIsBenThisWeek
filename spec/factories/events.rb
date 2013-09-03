# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    external_id "MyString"
    client "MyString"
    start_time "2013-09-02 11:41:00"
    end_time "2013-09-02 11:41:00"
    sequence 1
    latitude 1.5
    longitude 1.5
    recurs false
  end
end
