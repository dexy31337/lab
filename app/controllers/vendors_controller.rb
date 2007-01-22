class VendorsController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @vendor_pages, @vendors = paginate :vendors, :per_page => 10
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(params[:vendor])
    if @vendor.save
      flash[:notice] = 'Vendor was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update_attributes(params[:vendor])
      flash[:notice] = 'Vendor was successfully updated.'
      redirect_to :action => 'show', :id => @vendor
    else
      render :action => 'edit'
    end
  end

  def destroy
    Vendor.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
