require 'test_helper'

class ExaminationsControllerTest < ActionDispatch::IntegrationTest
  test "should get date:Datetime" do
    get examinations_date:Datetime_url
    assert_response :success
  end

  test "should get diagnosis:String" do
    get examinations_diagnosis:String_url
    assert_response :success
  end

end
