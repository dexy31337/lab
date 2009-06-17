class RmaDevicesController < ApplicationController


  def list
     @rma_device = RmaDevice.find(:all)
  end

  def show
    @rma_device = RmaDevice.find(:all)
  end

  def new
    @rma_device = RmaDevice.new
  end


#  def rma_log (device,rma_device_id)
#    device.rma_device_id = rma_device_id
#    device.save
#    Device.find(:all,:conditions => ['device_id = ?',device[:id]]).collect.each do |dev|
#      rma_log (dev,rma_device_id)
#    end
#  end

  def create
    @rma_devices = RmaDevice.new(params[:rma_device])
   if @rma_devices.save 
   Device.find(:all).each do |dev|
      if(params['device_'+dev.id.to_s] != nil )
        checked = params['device_'+dev.id.to_s]['checked']
          if(checked != nil && checked.length > 0)
            dev.rma_device_id = @rma_devices.id
            dev.save
#             rma_log(dev,@rma_devices[:id])
            end
	  end
       end
     redirect_to :action => 'list'
    end
  end

  def edit
    @rma_device = RmaDevice.find(params[:id])
  end

  def destroy
 RmaDevice.find(params[:id]).destroy
  
    redirect_to :action => 'list'
  end
end



