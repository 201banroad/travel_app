require "test_helper"

class SpotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @spot = spots(:one)
  end

  test "should get index" do
    get spots_url
    assert_response :success
  end

  test "should get show" do
    get spot_url(@spot)
    assert_response :success
  end

  test "should get new" do
    get new_spot_url
    assert_response :success
  end

  test "should get new when authenticated" do
    sign_in @user
    get new_spot_url
    assert_response :success
  end
end
