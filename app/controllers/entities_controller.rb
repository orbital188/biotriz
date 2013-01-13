class EntitiesController < ApplicationController
  def index
    @entities = Entity.all
  end

  def show
    @entity = Entity.find(params[:id])
  end

  def new
    @entity = Entity.new
  end

  def create
    @entity = Entity.new(params[:entity])
    if @entity.save
      redirect_to @entity, :notice => "Successfully created entity."
    else
      render :action => 'new'
    end
  end

  def edit
    @entity = Entity.find(params[:id])
  end

  def update
    @entity = Entity.find(params[:id])
    if @entity.update_attributes(params[:entity])
      redirect_to @entity, :notice  => "Successfully updated entity."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @entity = Entity.find(params[:id])
    @entity.destroy
    redirect_to entities_url, :notice => "Successfully destroyed entity."
  end
end
