class RmaDevicesController < ApplicationController


  def list
     @rma_devices = RmaDevice.find(:all)
  end

  def show
    @rma_devices = RmaDevice.find(:all)
  end

  def new
    @rma_devices = RmaDevice.new
  end


  def create
    @rma_devices = RmaDevice.new(params[:rma_devices])
    @rma_devices.save
#      RmaDevice.find(:all).each do |dev|
#      if(params['rma_device_'+dev.id.to_s] != nil )
#       checked = params['rma_device_'+dev.id.to_s]['checked']
#         if(checked != nil && checked.length > 0)
#            reserve(dev,@rma_devices[:id])
#         end
#       end
#     end
#    flash[:notice] = 'Rma device was successfully created.'
      redirect_to :action => 'list'
#    else @rma_devices = RmaDevice
#     render :action => 'new'
#    end
  end

  def edit
    @rma_devices = RmaDevice.find(params[:id])
  end

  def destroy
    @rma_devices = RmaDevice.find(params[:id])
    @rma_devices = RmaDevice.destroy
    redirect_to :action => 'list'
  end
end



