require File.dirname(__FILE__) + '/../test_helper'
require 'vendor_controller'

# Re-raise errors caught by the controller.
class VendorController; def rescue_action(e) raise e end; end

class VendorControllerTest < Test::Unit::TestCase
  def setup
    @controller = VendorController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
