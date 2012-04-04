require 'test_helper'

class FilJoieControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get apercu" do
    get :apercu
    assert_response :success
  end

end
