require 'test_helper'

class AuthentificationControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get sign_in" do
    get :sign_in
    assert_response :success
  end

  test "should get sign_out" do
    get :sign_out
    assert_response :success
  end

end
