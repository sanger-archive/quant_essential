# frozen_string_literal: true

require 'test_helper'

class QuantTest < ActiveSupport::TestCase
  attr_reader :quant
  setup do
    @standard = create :standard, created_at: DateTime.parse('01/01/2000')
    @quant = create :quant, created_at: DateTime.parse('05/01/2000'), standard: @standard
  end

  test 'standard_age_at_creation returns age of standard' do
    assert_equal 5, quant.standard_age_at_creation
  end
  test 'standard_expired_at_creation? returns false when in date' do
    refute quant.standard_expired_at_creation?
  end

  test 'standard_expired_at_creation? returns true when out of date' do
    standard_type = create :standard_type, lifespan: 2
    standard = create :standard, created_at: DateTime.parse('01/01/2000'), standard_type: standard_type
    expired_quant = create :quant, standard: standard, created_at: DateTime.parse('05/01/2000')
    assert expired_quant.standard_expired_at_creation?
  end
end
