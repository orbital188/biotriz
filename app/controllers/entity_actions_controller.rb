class EntityActionsController < ApplicationController
  def index
    @entity_actions = EntityAction.paginate page: params[:page]
  end

  def show
    @entity_action = EntityAction.find(params[:id])
  end

  def new
    @entity_action = EntityAction.new
  end

  def create
    @entity_action = EntityAction.new(params[:entity_action])
    if @entity_action.save
      redirect_to @entity_action, :notice => "Successfully created entity action."
    else
      render :action => 'new'
    end
  end

  def edit
    @entity_action = EntityAction.find(params[:id])
  end

  def update
    @entity_action = EntityAction.find(params[:id])
    if @entity_action.update_attributes(params[:entity_action])
      redirect_to @entity_action, :notice  => "Successfully updated entity action."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @entity_action = EntityAction.find(params[:id])
    @entity_action.destroy
    redirect_to entity_actions_url, :notice => "Successfully destroyed entity action."
  end
end
