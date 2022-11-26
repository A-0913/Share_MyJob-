require "test_helper"

class Public::RepliesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_replies_index_url
    assert_response :success
  end

  test "should get new" do
    get public_replies_new_url
    assert_response :success
  end
end
