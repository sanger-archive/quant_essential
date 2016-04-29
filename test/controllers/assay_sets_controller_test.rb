require 'test_helper'

class AssaySetsControllerTest < ActionController::TestCase
  test "should get index" do
    assay_set = create :assay_set
    get :index
    assert_response :success
    assert_not_nil assigns(:assay_sets)
    assert assigns(:assay_sets).include?(assay_set)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should allow creation of assay sets" do
    assert_difference('AssaySet.count') do
      post :create, assay_set: {assay_count: 5}
    end
    assert_not_nil assigns(:assay_set)
    assert_redirected_to assay_set_path(assigns(:assay_set).friendly_uuid)
  end

  test "should get show with a full uuid" do
    assay_set = create :assay_set, uuid: "0de0bb87-68c2-4469-955e-10f86b367999"
    get :show, uuid: '0de0bb87-68c2-4469-955e-10f86b367999'
    assert_equal assay_set, assigns(:assay_set)
    assert_response :success
  end

  test "should get show with a friendly encoded uuid" do
    assay_set = create :assay_set, uuid: "0de0bb87-68c2-4469-955e-10f86b367999"
    get :show, uuid: 'tkspirnyz3urjnu89wd29bq1'
    assert_equal assay_set, assigns(:assay_set)
    assert_response :success
  end

  test "should get show with an case insensitive encoded uuid" do
    assay_set = create :assay_set, uuid: "0de0bb87-68c2-4469-955e-10f86b367999"
    get :show, uuid: 'tkspIRNYz3urjnu89wd29bq1'
    assert_equal assay_set, assigns(:assay_set)
    assert_response :success
  end

end
