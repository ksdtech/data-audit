require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Feed.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Feed.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Feed.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to feed_url(assigns(:feed))
  end
  
  def test_edit
    get :edit, :id => Feed.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Feed.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Feed.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Feed.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Feed.first
    assert_redirected_to feed_url(assigns(:feed))
  end
  
  def test_destroy
    feed = Feed.first
    delete :destroy, :id => feed
    assert_redirected_to feeds_url
    assert !Feed.exists?(feed.id)
  end
end
