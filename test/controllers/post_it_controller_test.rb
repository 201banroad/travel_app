require "test_helper"

class PostItControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post_it = post_its(:one)
  end

  test "should get new" do
    sign_in @user
    get new_post_it_url
    assert_response :success
  end

  test "should get create" do
    sign_in @user
    post post_its_url, params: { post_it: { content: "Test content" } }
    assert_response :redirect
  end

  test "should get destroy" do
    sign_in @user
    delete post_it_url(@post_it)
    assert_response :redirect
  end
end
