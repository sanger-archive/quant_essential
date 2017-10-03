require 'test_helper'

class StandardsControllerTest < ActionController::TestCase
  test 'should get index' do
    standard = create :standard
    get :index
    assert_response :success
    assert_not_nil assigns(:standards)
    assert assigns(:standards).include?(standard)
  end

  test 'should filter by lot_number' do
    standard = create :standard, lot_number: '123'
    other_standard = create :standard, lot_number: '456'
    get :index, lot_number: '123'
    assert_response :success
    assert_not_nil assigns(:standards)
    assert assigns(:standards).include?(standard)
    refute assigns(:standards).include?(other_standard)
  end

  test 'should get show' do
    standard = create :standard
    get :show, barcode: standard.barcode
    assert_response :success
    assert_equal standard, assigns(:standard)
  end
end
