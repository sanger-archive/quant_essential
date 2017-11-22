# frozen_string_literal: true

require 'test_helper'

class QuantTypesControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
    assert assigns(:quant_type)
  end

  test 'should get edit' do
    quant_type = create :quant_type
    get :edit, id: quant_type.id
    assert_response :success
    assert_equal quant_type, assigns(:quant_type)
  end

  test 'should get index' do
    quant_type = create :quant_type
    get :index
    assert_response :success
    assert_includes assigns(:quant_types), quant_type
  end

  test 'should get show' do
    quant_type = create :quant_type
    get :show, id: quant_type.id
    assert_response :success
    assert_equal quant_type, assigns(:quant_type)
  end

  test 'show allow creation' do
    standard_type = create :standard_type
    assert_difference('QuantType.count') do
      post :create, quant_type: { name: 'Boris', standard_type_id: standard_type.id }
    end
    assert_equal 'Boris', QuantType.last.name
    assert_equal standard_type, QuantType.last.standard_type
  end

  test 'show allow update' do
    quant_type = create :quant_type
    new_standard_type = create :standard_type
    put :update, id: quant_type.id, quant_type: { name: 'Boris', standard_type_id: new_standard_type.id }
    assert_equal 'Boris', QuantType.find(quant_type.id).name
    assert_equal new_standard_type, QuantType.find(quant_type.id).standard_type
  end
end
