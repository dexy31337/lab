class SeriesController < ApplicationController
	scaffold :series
	def index
	   render :action => 'list'
	end

	def list
	end

	def v_series
	   @series = Series.find(:all,:conditions => {:vendor_id => params[:vendor]},:order => 'name ASC')
	   @series_chasis = Series.find(:all,:conditions => {:vendor_id => params[:vendor],:chasis => :true}, :order => 'name ASC'}
	   
	   @series_module = Series.find(:all,:conditions => {:vendor_id => params[:vendor],:chasis => :false}, :order => 'name ASC'}
	   render :partial => "v_series"
 	end
	
	def create
	   @series = Series.new(params[:series])
	   if @series.save
	      flash[:notice] = 'Series was successfully created.'
	      redirect_to :action => 'index'
	   else
	      render :action => 'new'
	   end
	end
	
	def compatibility
	  @series = Series.find(params[:id])
	  #@series_chasis = Series.find(
	  @compatible = @series.series.collect
	  @incompatible = Series.find(:all,:conditions => {:vendor_id => @series.vendor.id}).collect - @compatible - [@series]
	  render :partial => 'compat'
	end

	def addcompat
	  @series = Series.find(params[:id])
	  @toadd = Series.find(params[:series])
	  @series.series << @toadd unless @series.series.include?(@toadd)
	  @compatible = @series.series.collect
	  @incompatible = Series.find(:all,:conditions => {:vendor_id => @series.vendor.id}).collect - @compatible - [@series]
	  render :partial => 'compat'
	end
	
	def delcompat
	  @series = Series.find(params[:id])
	  @todel = Series.find(params[:series])
	  @series.series.delete(@todel)
	  @compatible = @series.series.collect
	  @incompatible = Series.find(:all,:conditions => {:vendor_id => @series.vendor.id}).collect - @compatible - [@series]
	  render :partial => 'compat'
	end
	
	def modcompat
	  @series = Series.find(params[:id])
	  @tomod = Series.find(params[:series])
	  if(params[:do] == 'add')
  	     @series.series << @tomod unless @series.series.include?(@tomod)
	     @tomod.series << @series unless @tomod.series.include?(@series)
	  end

	  if(params[:do] == 'del')
	     @series.series.delete(@tomod) if @series.series.include?(@tomod)
	     @tomod.series.delete(@series) if @tomod.series.include?(@series)
	  end
	  @compatible = @series.series.collect
	  @incompatible = Series.find(:all,:conditions => {:vendor_id => @series.vendor.id}).collect - @compatible - [@series]
	  @series = Series.find(:all,:conditions => {:vendor_id => @series.vendor.id},:order => 'name ASC')
	  render :partial => "v_series" 
	end
	
	def delete
	  @series = Series.find(params[:id])
	  @series.series.collect.each do |s|
	    s.series.delete(@series) if s.series.include?(@series)
	  end
	  @series.destroy
	  redirect_to :action => 'list'
	end

end
