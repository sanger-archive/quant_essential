FactoryGirl.define do
  sequence :label_template_name do |i|
    "template_#{i}"
  end

  sequence :external_id, &:to_s

  factory :label_template do
    name { generate :label_template_name }
    external_id
  end
end
