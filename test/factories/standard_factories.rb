FactoryGirl.define do

  sequence :standard_type_name do |i|
    "standard_type_#{i}"
  end

  factory :standard_type do
    name { generate :standard_type_name }
  end

  factory :standard_set do
    standard_count 5
    standard_type_id { create(:standard_type).id }
  end

  factory :standard do
    standard_type
    standard_set
  end

end
