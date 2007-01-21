require File.dirname(__FILE__) + '/../test_helper'
require 'engineer_controller'

# Re-raise errors caught by the controller.
class EngineerController; def rescue_action(e) raise e end; end

class EngineerControllerTest < Test::Unit::TestCase
  def setup
    @controller = EngineerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
