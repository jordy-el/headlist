require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new
    @user.email = 'john@smith.com'
    @user.password = 'password'
    @user.password_confirmation = 'password'
    @user.first_name = 'John'
    @user.last_name = 'Smith'
    @user.date_of_birth = Date.new(1995, 5, 26)
    @user.city = 'Melbourne'
  end

  test 'creates valid user' do
    assert @user.save!
  end

  # Missing attributes

  test 'rejects missing email' do
    @user.email = nil
    assert_not @user.save
  end

  test 'rejects missing password' do
    @user.password = nil
    assert_not @user.save
  end

  test 'rejects missing confirmation' do
    @user.password_confirmation = ''
    assert_not @user.save
  end

  test 'rejects missing first name' do
    @user.first_name = nil
    assert_not @user.save
  end

  test 'rejects missing last name' do
    @user.last_name = nil
    assert_not @user.save
  end

  # Invalid format attributes

  test 'rejects invalid email format' do
    @user.email = 'asdasd'
    assert_not @user.save
  end

  test 'rejects too short password' do
    @user.password = 'asd'
    @user.password_confirmation = 'asd'
    assert_not @user.save
  end

  test 'rejects incorrect first name format' do
    @user.first_name = '123'
    assert_not @user.save
  end

  test 'allows hyphenated first name' do
    @user.first_name = 'Mary-Beth'
    assert @user.save!
  end

  test 'rejects incorrect last name format' do
    @user.last_name = '123'
    assert_not @user.save
  end

  test 'allows hyphenated last name' do
    @user.last_name = 'Smith-Jones'
    assert @user.save!
  end

  test 'rejects incorrect city format' do
    @user.city = '1234'
    assert_not @user.save
  end

  test 'allows spaces in city name' do
    @user.city = 'New York'
    assert @user.save!
  end

  test 'allows hyphenated city name' do
    @user.city = 'Something-else'
    assert @user.save!
  end
end
