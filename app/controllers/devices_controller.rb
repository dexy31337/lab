class DevicesController < ApplicationController
	
  before_filter :protect_controller, :except => [:list, :show, :index, :search]
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
#  verify :method => "post", :only => [ :destroy, :create, :update ],
#         :redirect_to => { :action => :list }

protected
  def protect_controller
    if current_user.has_role?("dev_editor","dev_admin")
      return true
    else
      redirect_to "/devices/index"
      flash[:notice] = "Не достаточно прав!"
      return false
    end
  end
public
  def index
    list
    render :action => 'list'
  end

  def list
    @device_pages, @devices = paginate :devices, :per_page => 16, :order_by => params[:order]
  end

  def show
    @device = Device.find(params[:id])
  end
  
  def search
    if params[:searchfield].to_s = "any"
    	searchquery = '( labnumber LIKE %'+params[:searchtext].to_s+'% OR partnumber LIKE %'+params[:searchtext].to_s+'% OR serialnmber LIKE %'+params[:searchtext].to_s+'% OR name LIKE %'+params[:searchtext].to_s+'%)'
    else
    	searchquery = '('+params[:searchfield].to_s + " LIKE '%" + params[:searchtext].to_s + "%')"
    end
    if !current_user.has_role?('PowerUser')
    	searchquery += 'AND labnumber LIKE \'L%\''
    end
    searchquery += ' AND (reservation_id IS NOT NULL)'if params[:searchdevices] == 'reserved'
    searchquery += ' AND (reservation_id IS NULL)'if params[:searchdevices] == 'free'
    searchquery += ' AND (device_id IS NULL)' if params[:searchdevtype] == 'chasis'
    searchquery += ' AND (device_id IS NOT NULL)' if params[:searchdevtype] == 'modules'
    searchquery += (' AND (vendor_id = ' + params[:searchvendor].to_s + ')') if (params[:searchvendor] != nil and params[:searchvendor].to_s != 'all')
    
    @device_pages, @devices = paginate :devices, :per_page => 16, :order_by => params[:order], :conditions=> searchquery
    render :partial=>'search'
  end

  def new
    if !current_user.has_role?("dev_admin")
      redirect_to "/devices/index"
      flash[:notice] = "Не достаточно прав!"
      return false
    end
    @device = Device.new
    @device.modular = 1
  end

  def create
    if !current_user.has_role?("dev_editor","dev_admin")
      redirect_to "/devices/index"
      flash[:notice] = "Не достаточно прав!"
      return false
    end
    @device = Device.new(params[:device])
    if params[:serving_property] != nil
    	@serving_property = ServingProperty.new(params[:serving_property])
	@serving_property.save
	@device.serving_property_id = @serving_property.id
    end
    if @device.save
      flash[:notice] = 'Device was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @device = Device.find(params[:id])
    if @device[:serving_property_id] != nil
    	@serving_property = ServingProperty.find(@device[:serving_property_id])
    end
  end

  def update
    @device = Device.find(params[:id])
    @device.update_attributes(params[:device])
    if params[:serving_property] == nil
    	if @device[:serving_property_id] != nil
		sp_id_to_delete = @device[:serving_property_id];
		@device[:serving_property_id] = nil
		@device.save
	   	ServingProperty.find(sp_id_to_delete).destroy
	end
    else
    	if @device[:serving_property_id] != nil
	    	ServingProperty.find(@device[:serving_property_id]).update_attributes(params[:serving_property])
	else
	  	@serving_property = ServingProperty.new(params[:serving_property])
		@serving_property.save
		@device[:serving_property_id] = @serving_property[:id]
		#params[:device[:serving_property_id]] = @serving_property[:id]
	end
    end
    if @device.save
      flash[:notice] = 'Device was successfully updated.'
      redirect_to :action => 'show', :id => @device
    else
      render :action => 'edit'
    end
  end

  def destroy
    if !current_user.has_role?("dev_admin")
      redirect_to "/devices/index"
      flash[:notice] = "Не достаточно прав!"
      return false
    end

    Device.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
 
#  def render_partial
#    render :partial => params[:name].to_s
#  end

  def render_servprops
    render :partial => 'server_props'
  end
  
  def render_no_servprops
    render :partial => 'no_server_props'
  end
  
  def seriesadd
    @series = Series.find(:all,:conditions => {:vendor_id => params[:vendor]})
    render :partial => 'v_series'
  end
end
