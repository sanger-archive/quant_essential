# frozen_string_literal: true

require 'test_helper'

class QuantsControllerTest < ActionController::TestCase
  class MockUserLookup
    def initialize(user)
      @user = user
    end

    def find(_swipe)
      @user
    end
  end

  test 'should get new' do
    quant_type = create :quant_type
    get :new
    assert_response :success
    assert assigns(:quant)
    assert assigns(:quant_types)
    assert_includes assigns(:quant_types), [quant_type.name, quant_type.id]
  end

  test 'should get index' do
    get :index
    assert assigns(:quants)
    assert_response :success
  end

  test 'should get show' do
    quant = create :quant
    get :show, assay_barcode: quant.assay.barcode
    assert assigns(:quant)
    assert_equal quant, assigns(:quant)
    assert_response :success
  end

  setup do
    @cache_lookup = User.external_service
  end

  test 'should allow quant creation' do
    User.external_service = MockUserLookup.new({ login: 'mock', uuid: SecureRandom.uuid })

    assay = create :assay
    standard = create :standard
    quant_type = create :quant_type, standard_type: standard.standard_type
    input = create :input

    assert_difference('Quant.count') do
      post :create, { quant: {
        swipecard_code: 'swipe',
        quant_type: quant_type.id,
        assay_barcode: assay.barcode,
        standard_barcode: standard.barcode,
        input_barcode: input.barcode
      } }
    end

    assert_not_nil assigns(:quant)
    assert_redirected_to quant_path(assay.barcode)
  end

  teardown do
    User.external_service = @cache_lookup
  end
end
