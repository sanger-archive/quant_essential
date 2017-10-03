# frozen_string_literal: true

require 'test_helper'

class InputsControllerTest < ActionController::TestCase
  test 'index' do
    input = create :input
    get :index
    assert_response :success
    assert_not_nil assigns(:inputs)
    assert assigns(:inputs).include?(input)
  end

  test 'show' do
    input = create :input
    get :show, barcode: input.barcode
    assert_response :success
    assert_equal input, assigns(:input)
  end

  test 'should return assay uuid for /input' do
    quant = create :quant
    @request.accept = 'text/plain'
    get :show, { quant_assay_barcode: quant.assay_barcode }
    assert_equal quant.input.uuid, response.body
  end
end
