FactoryGirl.define do

  sequence :label_template_name do |i|
    "template_#{i}"
  end

  sequence :external_id do |i|
    "#{i}"
  end

  factory :label_template do
    name { generate :label_template_name }
    external_id
  end
end
