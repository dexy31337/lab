require File.dirname(__FILE__) + '/../test_helper'
require 'series_controller'

# Re-raise errors caught by the controller.
class SeriesController; def rescue_action(e) raise e end; end

class SeriesControllerTest < Test::Unit::TestCase
  def setup
    @controller = SeriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
