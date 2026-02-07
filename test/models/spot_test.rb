require "test_helper"

class SpotTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @spot = @user.spots.build(
      title: "Test Spot",
      location: "Tokyo",
      description: "This is a test spot description"
    )
    @spot.images.attach(io: StringIO.new("fake image"), filename: "test.jpg", content_type: "image/jpeg")
    @spot.save!
  end

  # バリデーションテスト
  test "should be valid with valid attributes" do
    assert @spot.valid?
  end

  test "title should be present" do
    @spot.title = nil
    assert_not @spot.valid?
  end

  test "title should not exceed 30 characters" do
    @spot.title = "a" * 31
    assert_not @spot.valid?
  end

  test "description should be present" do
    @spot.description = nil
    assert_not @spot.valid?
  end

  test "description should not exceed 500 characters" do
    @spot.description = "a" * 501
    assert_not @spot.valid?
  end

  test "location should not exceed 15 characters" do
    @spot.location = "a" * 16
    assert_not @spot.valid?
  end

  test "images should be present" do
    @spot.images.purge
    assert_not @spot.valid?
  end

  test "images must be image files" do
    @spot.images.purge
    @spot.images.attach(io: StringIO.new("text content"), filename: "test.txt", content_type: "text/plain")
    assert_not @spot.valid?
  end

  test "should not exceed 4 images" do
    @spot.images.purge
    5.times do |i|
      @spot.images.attach(io: StringIO.new("fake image #{i}"), filename: "test#{i}.jpg", content_type: "image/jpeg")
    end
    assert_not @spot.valid?
  end

  test "description should not exceed 10 lines" do
    @spot.description = ("line\n" * 11).strip
    assert_not @spot.valid?
  end

  # アソシエーションテスト
  test "should belong to user" do
    assert_respond_to @spot, :user
  end

  test "should have many likes" do
    assert_respond_to @spot, :likes
  end

  test "should have many images" do
    assert_respond_to @spot, :images
  end

  # 削除時の依存関係テスト
  test "should destroy associated likes when spot is destroyed" do
    like = @spot.likes.create!(user: @user)
    like_id = like.id
    @spot.destroy
    assert_nil Like.find_by(id: like_id)
  end
end
