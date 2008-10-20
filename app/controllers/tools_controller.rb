class ToolsController < ApplicationController

	def create
		@tool = Tool.new(params[:tool])
		if @tool.save
			flash[:notice] = 'Tool was successfully created.'
			redirect_to :action => 'index'
		else
			session[:tool] = @tool
			redirect_to :action => 'new'
		end
	end
	
	def destroy
		@tool = Tool.find(params[:id])
		@tool.destroy
		redirect_to :action => 'index'
	end
	
	def edit
  		@tool = Tool.find(params[:id])
	end
	
	def index
		list
		render :action => 'list'
	end
	
        def new
  		unless @tool = session[:tool]
			@tool = Tool.new(params[:id])
		else
			session[:tool] = nil
		end
	end

	def show
                @tool = Tool.find(params[:id])
	end
	
	def list
		@tools = Tool.find(:all)
	end
	
#def search
#end
	
	def update
		@tool = Tool.find(params[:id])
		@tool.update_attributes(params[:tool])
		if @tool.save
			flash[:notice] = 'Tool was successefully saved'
			redirect_to :action => 'show', :id => @tool
		else
			render :action => 'edit'
		end
	end
	

end

