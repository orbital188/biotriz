class EnvironmentParametersController < ApplicationController
  before_filter :login_required

  def index
    @environment_parameters = EnvironmentParameter.paginate page: params[:page]
  end

  def show
    @environment_parameter = EnvironmentParameter.find(params[:id])
  end

  def new
    @environment_parameter = EnvironmentParameter.new
  end

  def create
    @environment_parameter = EnvironmentParameter.new(params[:environment_parameter])
    if @environment_parameter.save
      redirect_to @environment_parameter, :notice => "Successfully created environment parameter."
    else
      render :action => 'new'
    end
  end

  def edit
    @environment_parameter = EnvironmentParameter.find(params[:id])
  end

  def update
    @environment_parameter = EnvironmentParameter.find(params[:id])
    if @environment_parameter.update_attributes(params[:environment_parameter])
      redirect_to @environment_parameter, :notice  => "Successfully updated environment parameter."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @environment_parameter = EnvironmentParameter.find(params[:id])
    @environment_parameter.destroy
    redirect_to environment_parameters_url, :notice => "Successfully destroyed environment parameter."
  end
end
