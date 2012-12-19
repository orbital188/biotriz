class SizesController < ApplicationController
  def index
    @sizes = Size.all
  end

  def show
    @size = Size.find(params[:id])
  end

  def new
    @size = Size.new
  end

  def create
    @size = Size.new(params[:size])
    if @size.save
      redirect_to @size, :notice => "Successfully created size."
    else
      render :action => 'new'
    end
  end

  def edit
    @size = Size.find(params[:id])
  end

  def update
    @size = Size.find(params[:id])
    if @size.update_attributes(params[:size])
      redirect_to @size, :notice  => "Successfully updated size."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @size = Size.find(params[:id])
    @size.destroy
    redirect_to sizes_url, :notice => "Successfully destroyed size."
  end
end
