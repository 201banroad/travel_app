require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  # バリデーションテスト
  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "name should be unique" do
    duplicate_user = User.new(name: @user.name, email: "different@example.com", password: "password123", password_confirmation: "password123")
    assert_not duplicate_user.valid?
  end

  test "name should not exceed 20 characters" do
    @user.name = "a" * 21
    assert_not @user.valid?
  end

  test "profile should not exceed 70 characters" do
    @user.profile = "a" * 71
    assert_not @user.valid?
  end

  test "profile should not exceed 4 lines" do
    @user.profile = "line1\nline2\nline3\nline4\nline5"
    assert_not @user.valid?
  end

  # Devise関連テスト
  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = User.new(name: "Different Name", email: @user.email, password: "password123", password_confirmation: "password123")
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    user = User.new(name: "New User", email: "new@example.com", password: nil, password_confirmation: nil)
    assert_not user.valid?
  end

  test "password confirmation should match" do
    @user.password = "newpassword"
    @user.password_confirmation = "different"
    assert_not @user.valid?
  end

  # アソシエーションテスト
  test "should have associated spots" do
    assert_respond_to @user, :spots
  end

  test "should have associated likes" do
    assert_respond_to @user, :likes
  end

  test "should have associated post_its" do
    assert_respond_to @user, :post_its
  end

  test "should have avatar attachment" do
    assert_respond_to @user, :avatar
  end

  # 削除時の依存関係テスト
  test "should destroy associated spots when user is destroyed" do
    spot = @user.spots.build(title: "Test Spot", location: "Tokyo", description: "A test spot")
    spot.images.attach(io: StringIO.new("fake image"), filename: "test.jpg", content_type: "image/jpeg")
    spot.save!
    spot_id = spot.id
    @user.destroy
    assert_nil Spot.find_by(id: spot_id)
  end

  test "should destroy associated likes when user is destroyed" do
    spot = spots(:one)
    # 別のユーザーが既に like を持っている場合があるため、直接 user の like を削除してから作成
    Like.where(user: @user, spot: spot).delete_all
    like = @user.likes.create!(spot: spot)
    like_id = like.id
    @user.destroy
    assert_nil Like.find_by(id: like_id)
  end

  test "should destroy associated post_its when user is destroyed" do
    post_it = @user.post_its.create!(content: "Test content")
    post_it_id = post_it.id
    @user.destroy
    assert_nil PostIt.find_by(id: post_it_id)
  end
end
