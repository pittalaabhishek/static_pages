require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  setup do
    @admin = users(:michael)
    @non_admin = users(:archer)
    30.times do |i|
      User.create(name: "User #{i}", email: "user-#{i}@example.com", password: "password")
    end
    log_in_as(@admin)
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select "a", text: "delete", count: 0
  end
end
