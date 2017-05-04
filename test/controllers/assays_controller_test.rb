require 'test_helper'

class AssaysControllerTest < ActionController::TestCase
  test 'index' do
    assay = create :assay
    get :index
    assert_response :success
    assert_not_nil assigns(:assays)
    assert assigns(:assays).include?(assay)
  end

  test 'show' do
    assay = create :assay
    get :show, barcode: assay.barcode
    assert_response :success
    assert_equal assay, assigns(:assay)
  end
end
