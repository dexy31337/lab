require File.dirname(__FILE__) + '/../test_helper'
require 'interfaces_controller'

# Re-raise errors caught by the controller.
class InterfacesController; def rescue_action(e) raise e end; end

class InterfacesControllerTest < Test::Unit::TestCase
  fixtures :interfaces

  def setup
    @controller = InterfacesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:interfaces)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:interface)
    assert assigns(:interface).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:interface)
  end

  def test_create
    num_interfaces = Interface.count

    post :create, :interface => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_interfaces + 1, Interface.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:interface)
    assert assigns(:interface).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Interface.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Interface.find(1)
    }
  end
end
