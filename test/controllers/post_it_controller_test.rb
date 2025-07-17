require "test_helper"

class PostItControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get post_it_new_url
    assert_response :success
  end

  test "should get create" do
    get post_it_create_url
    assert_response :success
  end

  test "should get destroy" do
    get post_it_destroy_url
    assert_response :success
  end
end
