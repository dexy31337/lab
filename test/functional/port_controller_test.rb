require File.dirname(__FILE__) + '/../test_helper'
require 'port_controller'

# Re-raise errors caught by the controller.
class PortController; def rescue_action(e) raise e end; end

class PortControllerTest < Test::Unit::TestCase
  def setup
    @controller = PortController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
