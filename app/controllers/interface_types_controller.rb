class InterfaceTypesController < ApplicationController
before_filter :protect_controller

protected
  def protect_controller
    if current_user.has_role?("PowerUser")
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

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @interface_type_pages, @interface_types = paginate :interface_types, :per_page => 10
  end

  def show
    @interface_type = InterfaceType.find(params[:id])
  end

  def new
    @interface_type = InterfaceType.new
  end

  def create
    @interface_type = InterfaceType.new(params[:interface_type])
    if @interface_type.save
      flash[:notice] = 'InterfaceType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @interface_type = InterfaceType.find(params[:id])
  end

  def update
    @interface_type = InterfaceType.find(params[:id])
    if @interface_type.update_attributes(params[:interface_type])
      flash[:notice] = 'InterfaceType was successfully updated.'
      redirect_to :action => 'show', :id => @interface_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    InterfaceType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
