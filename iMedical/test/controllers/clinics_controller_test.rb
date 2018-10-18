require 'test_helper'

class ClinicsControllerTest < ActionDispatch::IntegrationTest
  test "should get name:String" do
    get clinics_name:String_url
    assert_response :success
  end

  test "should get address:String" do
    get clinics_address:String_url
    assert_response :success
  end

end
