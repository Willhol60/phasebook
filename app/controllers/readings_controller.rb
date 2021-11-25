class ReadingsController < ApplicationController
  def index
    if params[:query].present?
      @readings = User.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")[0].readings
      # books = Book.where("title ILIKE ?", "%#{params[:query]}%")
      # books.each { |book| @readings << book }
      # users.each { |user| @readings << user }
    else
      @readings = Reading.all
    end
    @comment = Comment.new
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

  # def edit
  #   @reading = Reading.find(params[:id])
  # end

  # def update
  #   @reading = Reading.find(params[:id])
  #   @reading.update(reading_params)
  #   redirect_to reading_path(@reading)
  # end

  def cheers
    @reading = Reading.find(params[:id])
    if current_user.voted_for? @reading
      @reading.unliked_by current_user
    else
      @reading.liked_by current_user
    end
    book = @reading.book
    # give an anchor to stop the page jumping
    # redirect_to book_readings_path(@reading.book, @reading)
    redirect_to book_readings_path(book, anchor: "reading-#{@reading.id}")
  end

  private

  def reading_params
    params.require(:reading).permit(:read_status, :start_date, :end_date, :user_rating, :cheers)
  end
end
