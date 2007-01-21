require File.dirname(__FILE__) + '/../test_helper'
require 'devices_controller'

# Re-raise errors caught by the controller.
class DevicesController; def rescue_action(e) raise e end; end

class DevicesControllerTest < Test::Unit::TestCase
  fixtures :devices

  def setup
    @controller = DevicesController.new
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

    assert_not_nil assigns(:devices)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:device)
    assert assigns(:device).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:device)
  end

  def test_create
    num_devices = Device.count

    post :create, :device => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_devices + 1, Device.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:device)
    assert assigns(:device).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Device.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Device.find(1)
    }
  end
end
