require 'test_helper'

class BarcodeTest < ActiveSupport::TestCase

  test "does not use the generator if barcodes are set directly" do
    barcode = Barcode.new(barcode:'12345')
    assert_equal '12345', barcode.barcode
  end

  test "uses the generator to set the barcode if passed generate" do
    barcode = Barcode.new(generate:'12345')
    assert_equal 'QNTE_12345', barcode.barcode
  end

end
