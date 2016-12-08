require 'test_helper'

class SchoolAssessmentResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get school_assessment_results_index_url
    assert_response :success
  end

  test "should get show" do
    get school_assessment_results_show_url
    assert_response :success
  end

end
