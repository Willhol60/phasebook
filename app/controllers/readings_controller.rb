class ReadingsController < ApplicationController

  def index
    @readings = Reading.all
  end

  def new
    @reading = Reading.new
  end

  def create
    @reading = Reading.new(reading_params)
    if @reading.save
      redirect_to reading_path(@reading)
    else
      render :new
    end
  end

  def edit

  end

  private

  def reading_params
    params.require(:)
  end
end
