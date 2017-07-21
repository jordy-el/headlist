require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create(email: "user@example.com", password: "password", password_confirmation: "password", first_name: "John", last_name: "Smith")
  end

  test "rejects empty post" do
    assert_not Post.new(content: "", user: @user, timeline: @user.timeline).save
  end
end
