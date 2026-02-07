require "test_helper"

class LikeTest < ActiveSupport::TestCase
  setup do
    # フィクスチャのlike を削除してテストをクリアな状態にする
    Like.delete_all
    @user = users(:one)
    @spot = spots(:one)
    @like = Like.new(user: @user, spot: @spot)
  end

  # バリデーションテスト
  test "should be valid with valid attributes" do
    assert @like.valid?
  end

  test "should require user" do
    @like.user = nil
    assert_not @like.valid?
  end

  test "should require spot" do
    @like.spot = nil
    assert_not @like.valid?
  end

  test "user_id and spot_id combination should be unique" do
    @like.save!
    duplicate_like = Like.new(user: @user, spot: @spot)
    assert_not duplicate_like.valid?
  end

  # アソシエーションテスト
  test "should belong to user" do
    assert_respond_to @like, :user
  end

  test "should belong to spot" do
    assert_respond_to @like, :spot
  end
end
