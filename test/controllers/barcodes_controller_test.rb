require 'test_helper'

class BarcodesControllerTest < ActionController::TestCase
  test 'should redirect to an assay' do
    assay = create :assay
    get :show, barcode: assay.barcode
    assert_redirected_to assay_path(assay)
  end

  test 'should redirect to a standard' do
    standard = create :standard
    get :show, barcode: standard.barcode
    assert_redirected_to standard_path(standard)
  end

  test 'should redirect to an input' do
    input = create :input
    get :show, barcode: input.barcode
    assert_redirected_to input_path(input)
  end

  test 'should redirect to an input if given a human barcode' do
    input = create :input
    barcode = SBCF::SangerBarcode.new(machine_barcode: input.barcode).human_barcode
    get :show, barcode: barcode
    assert_redirected_to input_path(input)
  end

  test 'should render a useful 404' do
    get :show, barcode: 'not_a_barcode'
    assert_response :not_found
    assert_equal 'not_a_barcode', assigns(:barcode)
    assert_template :show
  end
end
