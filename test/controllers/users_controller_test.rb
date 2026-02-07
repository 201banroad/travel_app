require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should show user profile" do
    get user_path(@user)
    assert_response :success
  end

  test "should redirect to login when accessing mypage without auth" do
    get mypage_path
    assert_redirected_to new_user_session_path
  end

  test "mypage should show current user profile when authenticated" do
    sign_in @user
    get mypage_path
    assert_response :success
  end
end
