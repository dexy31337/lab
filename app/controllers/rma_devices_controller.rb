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

      redirect_to :action => 'list'

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



