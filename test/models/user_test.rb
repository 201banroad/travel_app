require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

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

  test "should have associated spots" do
    assert_respond_to @user, :spots
  end

  test "should have associated likes" do
    assert_respond_to @user, :likes
  end

  test "should destroy associated spots when user is destroyed" do
    spot = @user.spots.build(title: "Test Spot", location: "Tokyo", description: "A test spot")
    # Attach a dummy image
    spot.images.attach(io: StringIO.new("fake image"), filename: "test.jpg", content_type: "image/jpeg")
    spot.save!
    spot_id = spot.id
    @user.destroy
    assert_nil Spot.find_by(id: spot_id)
  end
end
