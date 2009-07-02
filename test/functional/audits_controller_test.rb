require 'test_helper'

class AuditsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Audit.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Audit.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Audit.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to audit_url(assigns(:audit))
  end
  
  def test_edit
    get :edit, :id => Audit.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Audit.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Audit.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Audit.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Audit.first
    assert_redirected_to audit_url(assigns(:audit))
  end
  
  def test_destroy
    audit = Audit.first
    delete :destroy, :id => audit
    assert_redirected_to audits_url
    assert !Audit.exists?(audit.id)
  end
end
