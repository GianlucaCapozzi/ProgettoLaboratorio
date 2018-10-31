require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    def setup
        @user = User.new(name: "User", surname: "Example", email: "user@example.com", password: "foobar",
             password_confirmation: "foobar", birthdayDate: "15101965", birthdayPlace: "Milano", phoneNumber: "3421412316", cf: "XMPMCH80R23G502B")
    end

end
