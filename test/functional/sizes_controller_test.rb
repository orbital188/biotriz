require 'test_helper'

class SizesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Size.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Size.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Size.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to size_url(assigns(:size))
  end

  def test_edit
    get :edit, :id => Size.first
    assert_template 'edit'
  end

  def test_update_invalid
    Size.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Size.first
    assert_template 'edit'
  end

  def test_update_valid
    Size.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Size.first
    assert_redirected_to size_url(assigns(:size))
  end

  def test_destroy
    size = Size.first
    delete :destroy, :id => size
    assert_redirected_to sizes_url
    assert !Size.exists?(size.id)
  end
end
