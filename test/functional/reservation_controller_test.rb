require File.dirname(__FILE__) + '/../test_helper'
require 'reservation_controller'

# Re-raise errors caught by the controller.
class ReservationController; def rescue_action(e) raise e end; end

class ReservationControllerTest < Test::Unit::TestCase
  def setup
    @controller = ReservationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
