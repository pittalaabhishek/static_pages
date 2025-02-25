require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  # test "index including pagination" do
  #     log_in_as(@user)
  #     get users_path
  #     assert_template 'users/index'
  #     assert_select 'div.pagination'
  #     User.paginate(page: 1).each do |user|
  #     assert_select 'a[href=?]', user_path(user), text: user.name
  #     end
  # end
  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'

    # Debugging output
    puts "Users on page 1:"
    puts User.paginate(page: 1).pluck(:id, :name)

    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end