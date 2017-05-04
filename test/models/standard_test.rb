require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  test "requires a standard_type" do
    standard = build :standard, standard_type: nil
    assert_not standard.valid?
  end

  EXPECTED_BARCODE_PREFIX = "QNTE_S_"

  test "Generates a barcode after creation with the prefix #{EXPECTED_BARCODE_PREFIX}" do
    standard = create :standard
    assert standard.barcode.present?, "No barcode is present"
    assert standard.barcode.starts_with?(EXPECTED_BARCODE_PREFIX), "#{standard.barcode} does not begin with #{EXPECTED_BARCODE_PREFIX}"
  end

  test "Generates a barcode based on the id" do
    standard = create :standard
    assert_equal "#{EXPECTED_BARCODE_PREFIX}#{standard.id}", standard.barcode
  end
end
