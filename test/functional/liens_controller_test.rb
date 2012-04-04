require 'test_helper'

class LiensControllerTest < ActionController::TestCase
  setup do
    @lien = liens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:liens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lien" do
    assert_difference('Lien.count') do
      post :create, :lien => @lien.attributes
    end

    assert_redirected_to lien_path(assigns(:lien))
  end

  test "should show lien" do
    get :show, :id => @lien.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @lien.to_param
    assert_response :success
  end

  test "should update lien" do
    put :update, :id => @lien.to_param, :lien => @lien.attributes
    assert_redirected_to lien_path(assigns(:lien))
  end

  test "should destroy lien" do
    assert_difference('Lien.count', -1) do
      delete :destroy, :id => @lien.to_param
    end

    assert_redirected_to liens_path
  end
end
