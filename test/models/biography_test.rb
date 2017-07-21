require 'test_helper'

class BiographyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create(email: "user@example.com", password: "password", password_confirmation: "password", first_name: "John", last_name: "Smith")
    @biography = @user.biography
  end

  test "rejects invalid location" do
    @biography.location = "123562534"
    assert_not @biography.save
  end

  test "rejects invalid hometown" do
    @biography.hometown = "234234"
    assert_not @biography.save
  end

  test "rejects invalid school" do
    @biography.school = "12313"
    assert_not @biography.save
  end

  test "rejects invalid workplace" do
    @biography.workplace = "245343"
    assert_not @biography.save
  end

  test "rejects invalid website" do
    @biography.website = "123123"
    assert_not @biography.save
  end

  test "rejects invalid github" do
    @biography.github = "235345324"
    assert_not @biography.save
  end
end
