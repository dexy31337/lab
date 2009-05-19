class ReservationsController < ApplicationController
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
  verify :method => "post", :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @reservation_pages, @reservations = paginate :reservations, :per_page => 100, :order => :end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def reserve(device,reservation_id)
    device.reservation_id = reservation_id
    device.save
    Device.find(:all,:conditions => ['device_id = ?',device[:id]]).collect.each do |dev|
      reserve(dev,reservation_id)
    end
  end
  
  def free_reservation(device)
    device.reservation_id = nil
    device.save
    Device.find(:all,:conditions => ['device_id = ?',device[:id]]).collect.each do |dev|
      free_reservation(dev)
    end
  end
  
  def create
    @reservation = Reservation.new(params[:reservation])
    if @reservation.save
      Device.find(:all).each do |dev|
      if(params['device_'+dev.id.to_s] != nil )
        checked = params['device_'+dev.id.to_s]['checked']
          if(checked != nil && checked.length > 0)
#            dev.reservation_id = @reservation.id
#            dev.save
             reserve(dev,@reservation[:id])
          end
        end
      end
      flash[:notice] = 'Reservation was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(params[:reservation])
      flash[:notice] = 'Reservation was successfully updated.'
      redirect_to :action => 'show', :id => @reservation
    else
      render :action => 'edit'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.devices.collect.each do |dev|
      free_reservation(dev)
    end
    @reservation.destroy
    redirect_to :action => 'list'
  end
end
