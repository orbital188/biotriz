class EntityFunctionsController < ApplicationController
  before_filter :login_required

  def index
    @entity_functions = EntityFunction.paginate page: params[:page]
  end

  def show
    @entity_function = EntityFunction.find(params[:id])
  end

  def new
    @entity_function = EntityFunction.new
  end

  def create
    @entity_function = EntityFunction.new(params[:entity_function])
    if @entity_function.save
      redirect_to @entity_function, :notice => "Successfully created entity function."
    else
      render :action => 'new'
    end
  end

  def edit
    @entity_function = EntityFunction.find(params[:id])
  end

  def update
    @entity_function = EntityFunction.find(params[:id])
    if @entity_function.update_attributes(params[:entity_function])
      redirect_to @entity_function, :notice  => "Successfully updated entity function."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @entity_function = EntityFunction.find(params[:id])
    @entity_function.destroy
    redirect_to entity_functions_url, :notice => "Successfully destroyed entity function."
  end
end
