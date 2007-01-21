require File.dirname(__FILE__) + '/../test_helper'
require 'interface_type_controller'

# Re-raise errors caught by the controller.
class InterfaceTypeController; def rescue_action(e) raise e end; end

class InterfaceTypeControllerTest < Test::Unit::TestCase
  def setup
    @controller = InterfaceTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
