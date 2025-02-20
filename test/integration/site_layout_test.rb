require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    # Step 1: Visit the root path
    get root_path

    # Step 2: Verify the correct template is rendered
    assert_template 'static_pages/home'

    # Step 3: Check for correct links
    assert_select "a[href=?]", root_path, count: 2  # Two links to Home (logo + navbar)
    assert_select "a[href=?]", help_path          # Help page link
    assert_select "a[href=?]", about_path         # About page link
    assert_select "a[href=?]", contact_path       # Contact page link
  end
end