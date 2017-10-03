# frozen_string_literal: true

require 'test_helper'

class QuantTypeTest < ActiveSupport::TestCase
  test 'name is unique' do
    quant_type_1 = create :quant_type
    quant_type_2 = build :quant_type, name: quant_type_1.name
    assert_not quant_type_2.valid?
    assert_includes quant_type_2.errors.full_messages, 'Name has already been taken'
  end
end
