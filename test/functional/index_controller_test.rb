require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get ajout_user" do
    get :ajout_user
    assert_response :success
  end

  test "should get ajout_article" do
    get :ajout_article
    assert_response :success
  end

  test "should get tracking" do
    get :tracking
    assert_response :success
  end

  test "should get moderation" do
    get :moderation
    assert_response :success
  end

end
