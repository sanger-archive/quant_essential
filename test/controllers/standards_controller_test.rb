require 'test_helper'

class StandardsControllerTest < ActionController::TestCase
  test "should get index" do
    standard = create :standard
    get :index
    assert_response :success
    assert_not_nil assigns(:standards)
    assert assigns(:standards).include?(standard)
  end

  test "should get show" do
    standard = create :standard
    get :show, barcode: standard.barcode
    assert_response :success
    assert_equal standard, assigns(:standard)
  end

end
