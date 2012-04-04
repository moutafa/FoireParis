require 'test_helper'

class AuteursControllerTest < ActionController::TestCase
  setup do
    @auteur = auteurs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auteurs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auteur" do
    assert_difference('Auteur.count') do
      post :create, :auteur => @auteur.attributes
    end

    assert_redirected_to auteur_path(assigns(:auteur))
  end

  test "should show auteur" do
    get :show, :id => @auteur.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @auteur.to_param
    assert_response :success
  end

  test "should update auteur" do
    put :update, :id => @auteur.to_param, :auteur => @auteur.attributes
    assert_redirected_to auteur_path(assigns(:auteur))
  end

  test "should destroy auteur" do
    assert_difference('Auteur.count', -1) do
      delete :destroy, :id => @auteur.to_param
    end

    assert_redirected_to auteurs_path
  end
end
