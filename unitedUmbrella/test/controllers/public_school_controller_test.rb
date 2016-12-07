require 'test_helper'

class PublicSchoolControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_school_index_url
    assert_response :success
  end

  test "should get show" do
    get public_school_show_url
    assert_response :success
  end

end
