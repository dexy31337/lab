require File.dirname(__FILE__) + '/../test_helper'
require 'configurator_controller'

# Re-raise errors caught by the controller.
class ConfiguratorController; def rescue_action(e) raise e end; end

class ConfiguratorControllerTest < Test::Unit::TestCase
  def setup
    @controller = ConfiguratorController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
