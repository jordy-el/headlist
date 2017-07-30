require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Smith')
    @notification = Notification.create(user: @user, message: 'asdasd', notification_type: 'asdasd')
  end

  test 'rejects missing message' do
    @notification.message = ''
    assert_not @notification.save
  end

  test 'rejects missing type' do
    @notification.notification_type = ''
    assert_not @notification.save
  end

  test 'sets notification as unseen on creation' do
    @notification.save
    assert_equal(@notification.seen, false)
  end
end
