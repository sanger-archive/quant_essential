# frozen_string_literal: true

require 'test_helper'

class StandardTypeTest < ActiveSupport::TestCase
  test 'name is unique' do
    standard_type1 = create :standard_type
    standard_type2 = build :standard_type, name: standard_type1.name
    assert_not standard_type2.valid?
    assert_includes standard_type2.errors.full_messages, 'Name has already been taken'
  end

  test 'can have a lifespan' do
    standard_type = build :standard_type, lifespan: 1
    assert standard_type.valid?
  end

  test 'does not require a lifespan' do
    standard_type = build :standard_type, lifespan: ''
    assert standard_type.valid?
  end

  test 'should have a lifespan greater than 1' do
    standard_type = build :standard_type, lifespan: 0
    refute standard_type.valid?
  end

  test 'should have numeric lifespan' do
    standard_type = build :standard_type, lifespan: 'one'
    refute standard_type.valid?
  end
end
