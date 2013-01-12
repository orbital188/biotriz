class ComplexitiesController < ApplicationController
  before_filter :login_required

  def index
    @complexities = Complexity.paginate page: params[:page]
  end

  def show
    @complexity = Complexity.find(params[:id])
  end

  def new
    @complexity = Complexity.new
  end

  def create
    @complexity = Complexity.new(params[:complexity])
    if @complexity.save
      redirect_to @complexity, :notice => "Successfully created complexity."
    else
      render :action => 'new'
    end
  end

  def edit
    @complexity = Complexity.find(params[:id])
  end

  def update
    @complexity = Complexity.find(params[:id])
    if @complexity.update_attributes(params[:complexity])
      redirect_to @complexity, :notice  => "Successfully updated complexity."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @complexity = Complexity.find(params[:id])
    @complexity.destroy
    redirect_to complexities_url, :notice => "Successfully destroyed complexity."
  end
end
