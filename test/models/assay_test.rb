require 'test_helper'

class AssayTest < ActiveSupport::TestCase
  EXPECTED_BARCODE_PREFIX = "QNTE_A_"
  test "Generates a barcode after creation with the prefix #{EXPECTED_BARCODE_PREFIX}" do
    assay = create :assay
    assert assay.barcode.present?, "No barcode is present"
    assert assay.barcode.starts_with?(EXPECTED_BARCODE_PREFIX), "#{assay.barcode} does not begin with #{EXPECTED_BARCODE_PREFIX}"
  end

  test "Generates a barcode based on the id" do
    assay = create :assay
    assert_equal "#{EXPECTED_BARCODE_PREFIX}#{assay.id}", assay.barcode
  end
end
