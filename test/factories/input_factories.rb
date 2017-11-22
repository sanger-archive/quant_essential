# frozen_string_literal: true

FactoryGirl.define do
  sequence :input_name do |i|
    "input_#{i}"
  end

  sequence :input_barcode do |i|
    SBCF::SangerBarcode.new(prefix: 'DN', number: i).machine_barcode.to_s
  end

  sequence :uuid do
    SecureRandom.uuid
  end

  factory :input do
    external_type 'example_type'
    name { generate :input_name }
    barcode { generate :input_barcode }
    uuid
  end
end
