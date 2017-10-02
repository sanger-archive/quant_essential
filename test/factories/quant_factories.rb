FactoryGirl.define do
  sequence :quant_type_name do |i|
    "quant_type_#{i}"
  end

  factory :quant_type do
    standard_type
    name { generate :quant_type_name }
  end

  factory :quant do
    quant_type
    assay
    standard
    input
    user
  end
end
