require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

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
