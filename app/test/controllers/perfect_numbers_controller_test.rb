require 'test_helper'

class PerfectNumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get check_sequence" do
    get perfect_numbers_check_sequence_url
    assert_response :success
  end

end
