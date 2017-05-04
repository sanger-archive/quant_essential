require 'test_helper'

class StandardSetTest < ActiveSupport::TestCase
  test 'StandardSets create standard_count standards of standard_type on creation' do
    as = nil
    standard_type = create :standard_type
    assert_difference('Standard.count', 5) do
      as = StandardSet.create!(standard_count: 5, standard_type_id: standard_type.id, lot_number: 'test_lot')
    end
    assert_equal 5, as.standards.count
    as.standards.each_with_index do |standard, i|
      assert_equal standard_type, standard.standard_type, "Standard #{i} is a #{standard.standard_type.name} not a #{standard.standard_type.name}"
      assert_equal 'test_lot', standard.lot_number
    end
  end

  test 'StandardSets requires an standard count' do
    standard_set = build :standard_set, standard_count: nil
    assert_not standard_set.save, 'Standard set was not invalid'
    assert_includes standard_set.errors.full_messages, 'Quantity needed is required and can not be left blank'
  end

  test 'StandardSets#standard_count must be numeric' do
    standard_set = build :standard_set, standard_count: 'Five'
    assert_not standard_set.save, 'Standard set was not invalid'
    assert_includes standard_set.errors.full_messages, 'Quantity needed is not a number'
  end

  test 'StandardSets#standard_count must be greater than zero' do
    standard_set = build :standard_set, standard_count: 0
    assert_not standard_set.save, 'Standard set was not invalid'
    assert_includes standard_set.errors.full_messages, 'Quantity needed must be greater than 0'
  end

  test 'StandardSets requires a standard type' do
    standard_set = build :standard_set, standard_type_id: nil
    assert_not standard_set.save, 'Standard set was not invalid'
    assert_includes standard_set.errors.full_messages, 'Standard type is required and can not be left blank'
  end
end
