require 'test_helper'

class PublicLeaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_lea_index_url
    assert_response :success
  end

  test "should get show" do
    get public_lea_show_url
    assert_response :success
  end

end
