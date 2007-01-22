class ReportsController < ApplicationController
  
#  before_filter :protect_controller, :except => [:list, :show, :index, :search]
#  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
#  verify :method => :post, :only => [ :destroy, :create, :update ],
#         :redirect_to => { :action => :list }

protected
  def protect_controller
    if current_user.has_role?("Admin")
      return true
    else
      redirect_to "/devices/index"
      flash[:notice] = "Не достаточно прав!"
      return false
    end
  end

public
  def index
  end
  
  def total_inv
  	@devs = Device.find(:all,:conditions => 'device_id is null')
  end
end
