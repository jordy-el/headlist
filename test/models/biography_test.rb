require 'test_helper'

class BiographyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Smith')
    @biography = @user.biography
  end
end
