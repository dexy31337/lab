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
  

  def search_total_report
	search_total += ('(vendor_id = ' + params[:location_params].to_s + ')') if (params[:location_params] != 	nil and params[:location_params].to_s != 'all')
	search_total += '(labnumber LIKE \'A%\')' if params[:labnumder_params] == 'type_A'
	search_total += '(labnumber LIKE \'L%\')' if params[:labnumder_params] == 'type_L'
	search_total += '(labnumber LIKE \'S%\')' if params[:labnumder_params] == 'type_S'
	search_total += '(labnumber LIKE \'P%\')' if params[:labnumder_params] == 'type_P'
	search_total += '(labnumber LIKE \'C%\')' if params[:labnumder_params] == 'type_C'
  end

  def list
  end
  
  def resaults_total_report
  	@device = Device.find(:all,:conditions => 'searhch_total',:order => 'params')
  end


  
  def total_inv_res
  	@devs = Device.find(:all,:conditions => 'device_id is null',:order => 'location')
  end
  
end
