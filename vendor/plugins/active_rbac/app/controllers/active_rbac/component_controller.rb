require_dependency 'application'

# All controllers in ActiveRBAC extend this controller.
#
# It is only responsible for loading the model classes and the RbacHelper
# at the moment.
class ActiveRbac::ComponentController < ApplicationController
  before_filter :protect_with_active_rbac
  model :user, :role, :group, :static_permission
  helper :rbac

private
	def protect_with_active_rbac
		# only protect certain controllers
		return true if([ActiveRbac::LoginController, ActiveRbac::RegistrationController].include?(self.class))
		# protect!
		return true if not session[:rbac_user].nil? and session[:rbac_user].has_role 'Admin'
		flash[:notice] = 'Недостаточно прав!'
		redirect_to '/access/login'
		return false
	end
	def protect me
	end

end