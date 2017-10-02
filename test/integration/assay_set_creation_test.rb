require 'test_helper'

class AssaySetCreationTest < ActionDispatch::IntegrationTest
  test 'assay set creation' do
    get '/assay_sets/new'
    assert_response :success
    assert_difference('Assay.count', 5) do
      post_via_redirect '/assay_sets', assay_set: { assay_count: 5 }
    end
    assert assigns(:assay_set)
    created = assigns(:assay_set)
    assert_equal assay_set_path(created.friendly_uuid), path
    get '/assay_sets'
    assert assigns(:assay_sets)
    assert_includes assigns(:assay_sets), created
  end
end
