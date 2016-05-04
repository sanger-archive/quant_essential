require 'test_helper'

class StandardTypeTest < ActiveSupport::TestCase
  test "name is unique" do
    standard_type_1 = create :standard_type
    standard_type_2 = build :standard_type, name: standard_type_1.name
    assert_not standard_type_2.valid?
    assert_includes standard_type_2.errors.full_messages, "Name has already been taken"
  end
end
