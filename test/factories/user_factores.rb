FactoryGirl.define do

  sequence :login do |i|
    "user_#{i}"
  end

  factory :user do
    login
    uuid
  end

end
