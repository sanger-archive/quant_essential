require 'test_helper'

class AssaySetTest < ActiveSupport::TestCase

  test "AssaySets create assay_count assays on creation" do
    as = nil
    assert_difference('Assay.count',5) do
      as = AssaySet.create!(assay_count: 5)
    end
    assert_equal 5, as.assays.count
  end

  test "AssaySets requires an assay count" do
    assay_set = AssaySet.new
    assert_not assay_set.save, "Assay set was not invalid"
    assert_includes assay_set.errors.full_messages, "Quantity needed is required and can not be left blank"
  end

  test "AssaySets#assay_count must be numeric" do
    assay_set = AssaySet.new(assay_count: "Five")
    assert_not assay_set.save, "Assay set was not invalid"
    assert_includes assay_set.errors.full_messages, "Quantity needed is not a number"
  end

  test "AssaySets#assay_count must be greater than zero" do
    assay_set = AssaySet.new(assay_count: 0)
    assert_not assay_set.save, "Assay set was not invalid"
    assert_includes assay_set.errors.full_messages, "Quantity needed must be greater than 0"
  end
end
