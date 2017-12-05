require 'test_helper'

class PerfectNumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get perfect_numbers_index_url
    assert_response :success
  end

end
