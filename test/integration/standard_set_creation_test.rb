require 'test_helper'

class StandardSetCreationTest < ActionDispatch::IntegrationTest
  test "standard set creation" do
    standard_type = create :standard_type
    get "/standard_sets/new"
    assert_response :success
    assert_includes assigns(:standard_types), [standard_type.name, standard_type.id]
    assert_difference('Standard.count', 5) do
      post_via_redirect "/standard_sets", standard_set: { standard_count: 5, standard_type_id: standard_type.id, lot_number: 'lot_number' }
    end
    assert assigns(:standard_set)
    created = assigns(:standard_set)
    assert_equal standard_set_path(created.friendly_uuid), path
    get "/standard_sets"
    assert assigns(:standard_sets)
    assert_includes assigns(:standard_sets), created
  end
end
