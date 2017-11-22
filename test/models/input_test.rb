# frozen_string_literal: true

require 'test_helper'

class InputTest < ActiveSupport::TestCase
  class MockSearch
    def initialize
      @plates = {}
    end

    def with(barcode, params)
      @plates[barcode] = params
    end

    def find(barcode)
      @plates[barcode]
    end
  end

  test 'Returns existing inputs' do
    input = create :input
    found_input = Input.find_with_barcode(input.barcode)
    assert_equal input, found_input
  end

  test 'Looks up non-existing barcodes in the specified service and creates a plate' do
    mock = MockSearch.new
    mock.with('12345', uuid: '00000000-0000-0000-0000-000000000005', name: 'Cherrypicked 397032', external_type: 'Cherrypicked')

    found_input = Input.find_with_barcode('12345', mock)

    assert_equal '00000000-0000-0000-0000-000000000005', found_input.uuid
    assert_equal 'Cherrypicked 397032', found_input.name
    assert_equal '12345', found_input.barcode
  end
end
