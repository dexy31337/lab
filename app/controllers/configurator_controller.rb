class ConfiguratorController < ApplicationController

	def index
		step_one
		render :action => "step_one"
	end

	def step_one
		@devices = Device.find(:all,:conditions => 'is_chasis = 1')
	end

	def step_two
		render :partial => 'step_two'
	end

	def step_three
		@device = Device.find(params['device'])
		@children = Array.new
		stack = [@device]
		while stack.length > 0 do
		  dev = stack.pop
		  if dev.devices != nil then 
		     dev.devices.each do |d|
		       @children.push(d)
		       stack.push(d)
		     end
		  end
	        end
		render :partial => 'step_three'
	end
	
	def create
		@res = [Device.find(params['device']['id'])]
		params[:device].each { |item_id,  attr| @res.push( Device.find(item_id)) if attr['used'] == '1'}
	end

end
