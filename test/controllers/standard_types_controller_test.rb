require 'test_helper'

class StandardTypesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    assert assigns(:standard_type)
  end

  test "should get edit" do
    standard_type = create :standard_type
    get :edit, id: standard_type.id
    assert_response :success
    assert_equal standard_type, assigns(:standard_type)
  end

  test "should get index" do
    standard_type = create :standard_type
    get :index
    assert_response :success
    assert_includes assigns(:standard_types), standard_type
  end

  test "should get show" do
    standard_type = create :standard_type
    get :show, id: standard_type.id
    assert_response :success
    assert_equal standard_type, assigns(:standard_type)
  end

  test "show allow creation" do
    assert_difference('StandardType.count') do
      post :create, standard_type: { name: 'Boris' }
    end
    assert_equal 'Boris', StandardType.last.name
  end

  test "show allow update" do
    standard_type = create :standard_type
    put :update, id: standard_type.id, standard_type: { name: 'Boris' }
    assert_equal 'Boris', StandardType.find(standard_type.id).name
  end
end
