require 'test_helper'

class EnvironmentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Environment.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Environment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Environment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to environment_url(assigns(:environment))
  end

  def test_edit
    get :edit, :id => Environment.first
    assert_template 'edit'
  end

  def test_update_invalid
    Environment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Environment.first
    assert_template 'edit'
  end

  def test_update_valid
    Environment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Environment.first
    assert_redirected_to environment_url(assigns(:environment))
  end

  def test_destroy
    environment = Environment.first
    delete :destroy, :id => environment
    assert_redirected_to environments_url
    assert !Environment.exists?(environment.id)
  end
end
