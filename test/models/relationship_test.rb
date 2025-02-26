require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id,
                                    followed_id: users(:archer).id)
  end

  test "should be valid" do
    puts @relationship.errors.full_messages unless @relationship.valid?
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should not allow duplicate relationships" do
    @relationship.save
    duplicate_relationship = Relationship.new(follower_id: users(:michael).id,
                                             followed_id: users(:archer).id)
    assert_not duplicate_relationship.valid?
  end
end
