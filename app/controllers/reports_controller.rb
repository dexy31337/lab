class ReportsController < ApplicationController
before_filter :protect_controller

protected
  def protect_controller
    if current_user.has_role?('PowerUser')
      return true
    else
      redirect_to "/devices/index"
      flash[:notice] = "Не достаточно прав!"
      return false
    end
  end

#  before_filter :protect_controller, :except => [:list, :show, :index, :search]
#  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
#  verify :method => "post", :only => [ :destroy, :create, :update ],
#         :redirect_to => { :action => :list }

public
  def index
     render :action => 'list'
  end
  
  def list
  end
  
  def total_inv
  	@devs = Device.find(:all,:conditions => 'device_id is null',:order => 'location')
  end
  
  def total_inv_res
  	@devs = Device.find(:all,:conditions => 'device_id is null',:order => 'location')
  end

  def cert_inv
  	@devs = Device.find(:all,:conditions => 'vendor_id = 2',:order => 'certification DESC,partnumber ASC')
  end
  
  def chasis_inv
  	@devs = Device.find(:all,:conditions => 'is_chasis = 1',:order => 'vendor_id ASC,partnumber ASC')
  end
  
end
