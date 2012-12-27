class EnvironmentsController < ApplicationController
  before_filter :login_required

  def index
    @environments = Environment.all
  end

  def show
    @environment = Environment.find(params[:id])
  end

  def new
    @environment = Environment.new
  end

  def create
    @environment = Environment.new(params[:environment])
    if @environment.save
      redirect_to @environment, :notice => "Successfully created environment."
    else
      render :action => 'new'
    end
  end

  def edit
    @environment = Environment.find(params[:id])
  end

  def update
    @environment = Environment.find(params[:id])
    if @environment.update_attributes(params[:environment])
      redirect_to @environment, :notice  => "Successfully updated environment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @environment = Environment.find(params[:id])
    @environment.destroy
    redirect_to environments_url, :notice => "Successfully destroyed environment."
  end
end
