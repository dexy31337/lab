require File.dirname(__FILE__) + '/../test_helper'
require 'engineers_controller'

# Re-raise errors caught by the controller.
class EngineersController; def rescue_action(e) raise e end; end

class EngineersControllerTest < Test::Unit::TestCase
  fixtures :engineers

  def setup
    @controller = EngineersController.new
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

    assert_not_nil assigns(:engineers)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:engineer)
    assert assigns(:engineer).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:engineer)
  end

  def test_create
    num_engineers = Engineer.count

    post :create, :engineer => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_engineers + 1, Engineer.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:engineer)
    assert assigns(:engineer).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Engineer.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Engineer.find(1)
    }
  end
end
