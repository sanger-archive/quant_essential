# frozen_string_literal: true

require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  test 'requires a standard_type' do
    standard = build :standard, standard_type: nil
    assert_not standard.valid?
  end

  EXPECTED_BARCODE_PREFIX = 'QNTE_S_'

  test "Generates a barcode after creation with the prefix #{EXPECTED_BARCODE_PREFIX}" do
    standard = create :standard
    assert standard.barcode.present?, 'No barcode is present'
    assert standard.barcode.starts_with?(EXPECTED_BARCODE_PREFIX), "#{standard.barcode} does not begin with #{EXPECTED_BARCODE_PREFIX}"
  end

  test 'Generates a barcode based on the id' do
    standard = create :standard
    assert_equal "#{EXPECTED_BARCODE_PREFIX}#{standard.id}", standard.barcode
  end

  test '#expired? returns false if we are before expiry' do
    standard_type = create :standard_type, lifespan: 2
    standard = create :standard, standard_type: standard_type
    refute standard.expired?
  end

  test '#expired? returns true if we are after expiry' do
    standard_type = create :standard_type, lifespan: 1
    standard = create :standard, standard_type: standard_type, created_at: DateTime.yesterday.end_of_day
    assert standard.expired?
  end

  test '#expired? returns false for even very old plates if no expiry is set' do
    standard_type = create :standard_type, lifespan: nil
    standard = create :standard, standard_type: standard_type, created_at: DateTime.parse('2/9/1666')
    refute standard.expired?
  end

  test 'age_at returns the age of a standard in days' do
    standard = create :standard, created_at: DateTime.parse('01/01/2000 20:00')
    assert_equal 4, standard.age_at(DateTime.parse('04/01/2000 10:00'))
  end

  test 'expired_at? returns false if expired' do
    standard_type = create :standard_type, lifespan: 3
    standard = create :standard, created_at: DateTime.parse('01/01/2000 20:00'), standard_type: standard_type
    assert standard.expired_at?(DateTime.parse('04/01/2000 10:00'))
  end
end
