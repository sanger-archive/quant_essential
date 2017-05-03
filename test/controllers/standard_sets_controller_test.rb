require 'test_helper'

class StandardSetsControllerTest < ActionController::TestCase
  test "should get index" do
    standard_set = create :standard_set
    get :index
    assert_response :success
    assert_not_nil assigns(:standard_sets)
    assert assigns(:standard_sets).include?(standard_set)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert assigns(:standard_set)
    assert assigns(:standard_types)
  end

  test "should allow creation of standard sets" do
    standard_type = create :standard_type
    assert_difference('StandardSet.count') do
      post :create, standard_set: {standard_count: 5, standard_type_id: standard_type.id, lot_number: 'test'}
    end
    assert_not_nil assigns(:standard_set)
    assert_equal 'test', assigns(:standard_set).standards.first.lot_number
    assert_redirected_to standard_set_path(assigns(:standard_set).friendly_uuid)
  end

  test "should get show with a full uuid" do
    standard_set = create :standard_set, uuid: "0de0bb87-68c2-4469-955e-10f86b367999"
    get :show, uuid: '0de0bb87-68c2-4469-955e-10f86b367999'
    assert_equal standard_set, assigns(:standard_set)
    assert_response :success
  end

  test "should get show with a friendly encoded uuid" do
    standard_set = create :standard_set, uuid: "0de0bb87-68c2-4469-955e-10f86b367999"
    get :show, uuid: 'tkspirnyz3urjnu89wd29bq1'
    assert_equal standard_set, assigns(:standard_set)
    assert_response :success
  end

  test "should get show with an case insensitive encoded uuid" do
    standard_set = create :standard_set, uuid: "0de0bb87-68c2-4469-955e-10f86b367999"
    get :show, uuid: 'tkspIRNYz3urjnu89wd29bq1'
    assert_equal standard_set, assigns(:standard_set)
    assert_response :success
  end

end
