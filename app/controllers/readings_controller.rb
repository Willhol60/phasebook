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
    @reading = Reading.find(params[:id])
  end

  def update
    @reading = Reading.find(params[:id])
    @reading.update(reading_params)
    redirect_to reading_path(@reading)
  end

  private

  def reading_params
    params.require(:reading).permit(:read_status, :start_date, :end_date, :user_rating, :cheers)
  end
end