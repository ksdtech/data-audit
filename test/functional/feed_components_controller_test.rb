require 'test_helper'

class FeedComponentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => FeedComponent.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    FeedComponent.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    FeedComponent.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to feed_component_url(assigns(:feed_component))
  end
  
  def test_edit
    get :edit, :id => FeedComponent.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    FeedComponent.any_instance.stubs(:valid?).returns(false)
    put :update, :id => FeedComponent.first
    assert_template 'edit'
  end
  
  def test_update_valid
    FeedComponent.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FeedComponent.first
    assert_redirected_to feed_component_url(assigns(:feed_component))
  end
  
  def test_destroy
    feed_component = FeedComponent.first
    delete :destroy, :id => feed_component
    assert_redirected_to feed_components_url
    assert !FeedComponent.exists?(feed_component.id)
  end
end
