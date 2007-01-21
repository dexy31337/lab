# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require_dependency "#{RAILS_ROOT}/vendor/plugins/active_rbac/app/helpers/rbac_helper"
class ApplicationController < ActionController::Base
  helper RbacHelper

  include ActiveRbacMixins::ApplicationControllerMixin
end
