class EngineersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @engineer_pages, @engineers = paginate :engineers, :per_page => 100, :order => :last
  end

  def show
    @engineer = Engineer.find(params[:id])
  end

  def new
    @engineer = Engineer.new
  end

  def create
    @engineer = Engineer.new(params[:engineer])
    if @engineer.save
      flash[:notice] = 'Engineer was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @engineer = Engineer.find(params[:id])
  end

  def update
    @engineer = Engineer.find(params[:id])
    if @engineer.update_attributes(params[:engineer])
      flash[:notice] = 'Engineer was successfully updated.'
      redirect_to :action => 'show', :id => @engineer
    else
      render :action => 'edit'
    end
  end

  def destroy
    Engineer.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
