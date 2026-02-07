require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @spot = spots(:one)
    Like.delete_all
  end

  test "should create like when authenticated" do
    sign_in @user
    assert_difference("Like.count") do
      post spot_like_url(@spot)
    end
    assert_response :redirect
  end

  test "should destroy like when authenticated" do
    sign_in @user
    @spot.likes.create!(user: @user)
    assert_difference("Like.count", -1) do
      delete spot_like_url(@spot)
    end
    assert_response :redirect
  end
end
