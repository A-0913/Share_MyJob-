require "test_helper"

class Public::JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_jobs_new_url
    assert_response :success
  end

  test "should get index" do
    get public_jobs_index_url
    assert_response :success
  end
end
