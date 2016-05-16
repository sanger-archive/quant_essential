FactoryGirl.define do

  sequence :printer_name do |i|
    "p#{i}bc"
  end

  factory :printer do
    name { generate :printer_name }
    label_template
  end
end
