require 'test_helper'

class PrescriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get type:String" do
    get prescriptions_type:String_url
    assert_response :success
  end

  test "should get comment:String" do
    get prescriptions_comment:String_url
    assert_response :success
  end

  test "should get medicinalName:String" do
    get prescriptions_medicinalName:String_url
    assert_response :success
  end

end
