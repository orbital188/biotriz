class PrinciplesController < ApplicationController
  before_filter :login_required

  def index
    @principles = Principle.paginate page: params[:page]
  end

  def show
    @principle = Principle.find(params[:id])
  end

  def new
    @principle = Principle.new
  end

  def create
    @principle = Principle.new(params[:principle])
    if @principle.save
      redirect_to @principle, :notice => "Successfully created principle."
    else
      render :action => 'new'
    end
  end

  def edit
    @principle = Principle.find(params[:id])
  end

  def update
    @principle = Principle.find(params[:id])
    if @principle.update_attributes(params[:principle])
      redirect_to @principle, :notice  => "Successfully updated principle."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @principle = Principle.find(params[:id])
    @principle.destroy
    redirect_to principles_url, :notice => "Successfully destroyed principle."
  end
end
