class InterfacesController < ApplicationController

before_filter :protect_controller, :except => [:list, :show, :index, :search, :showcross]

protected
  def protect_controller
    if current_user.has_role?("cross_editor","int_editor")
      return true
    else
      redirect_to "/interfaces/showcross"
      flash[:notice] = "Не достаточно прав!"
      return false
    end
  end
public
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => "post", :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @interface_pages, @interfaces = paginate :interfaces, :per_page => 10
  end

  def show
    @interface = Interface.find(params[:id])
  end

  def new
    @interface = Interface.new
  end

  def create
    @interface = Interface.new(params[:interface])
    if @interface.save
      flash[:notice] = 'Interface was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @interface = Interface.find(params[:id])
  end

  def update
    @interface = Interface.find(params["id"])
    @interface.attributes = params["interface"]
    if(@interface.interface)
      @interface.interface.interface_id = nil
      @interface.interface.save
    end
      if @interface.interface_id != nil
        @reverse_interface = Interface.find(@interface.interface_id)
        @reverse_interface.interface_id = @interface.id
        @reverse_interface.save
      end
    @interface.save
    flash[:notice] = "Done"
    redirect_to :action => :edit, :id => params[:id]
  end
  
  def destroy
    Interface.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def drawdevicedropdown
    render :partial => 'devicedropdown'
  end
  
  def generateints
    render :partial => 'interfaces'
  end
  
  def showcross
  end
  
  def uncross
    @interface = Interface.find(params["id"])
    if(@interface.interface)
      @interface.interface.interface_id = nil
      @interface.interface.save
    end
    Notifier::deliver_crossing_notify('Порт '+ @interface.name.to_s + ' раскросирован из порта ' + @interface.interface.name.to_s)
    @interface.interface_id = nil
    @interface.save
    redirect_to :action => :showcross
  end
	
  def cross
    @interface = Interface.find(params["id"])
    @interface.interface_id = params["interface_id"]
    @interface.save
    if(@interface.interface)
      @interface.interface.interface_id = @interface.id
      @interface.interface.save
    end
#    @interface.interface_id = nil
#    @interface.save
    redirect_to :action => :showcross
    Notifier::deliver_crossing_notify('Порт '+ @interface.name.to_s + ' скросирован в порт ' + @interface.interface.name.to_s)
  end  

  def toolbox
    render :partial => 'toolbox'
  end

  def testsubmit
    render :partial => 'testsubmit'
  end
end
