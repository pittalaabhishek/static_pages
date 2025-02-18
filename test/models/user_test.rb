class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  # Test that the user is valid initially
  test "should be valid" do
    assert @user.valid?
  end

  # Test that name must be present
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid? # Expect the user to be invalid
  end

  # Test that email must be present
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid? # Expect the user to be invalid
  end

  # Test for name length validation
  test "name should not be too long" do
    @user.name = "a" * 51  # String of 51 'a's
    assert_not @user.valid?
  end

  # Test for email length validation
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"  # Total length = 256
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end  
end
