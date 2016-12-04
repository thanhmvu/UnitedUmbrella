require 'test_helper'

class PublicSchoolGenderEnrollmentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_school_gender_enrollment_index_url
    assert_response :success
  end

  test "should get show" do
    get public_school_gender_enrollment_show_url
    assert_response :success
  end

  test "should get compare" do
    get public_school_gender_enrollment_compare_url
    assert_response :success
  end

end
