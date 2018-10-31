require 'test_helper'

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    binding.pry
    get homepage_index_url
    assert_response :success
  end

end
