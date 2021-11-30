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

  def start
    @reading = Reading.find(params[:id])
    @reading.update(read_status: "Current", start_date: DateTime.now)
    flash[:notice] = 'Your reading has been updated!'
    redirect_to request.referrer
  end

  def finish
    @reading = Reading.find(params[:id])
    @reading.update(read_status: "Finished", end_date: DateTime.now, user_rating: params[:reading][:user_rating])
    flash[:notice] = 'Your reading has been updated!'
    redirect_to request.referrer
  end

  def open_list_modal
    @reading = Reading.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

=begin
  def edit
    @reading = Reading.find(params[:id])
  end

  def update
    @reading = Reading.find(params[:id])
    @reading.update(reading_params)
    redirect_to reading_path(@reading)
  end
=end

  def cheers
    @reading = Reading.find(params[:id])
    if current_user.voted_for? @reading
      @reading.unliked_by current_user
    else
      @reading.liked_by current_user
    end
    # give an anchor to stop the page jumping
    # redirect_to book_readings_path(@reading.book, @reading)
    redirect_to book_readings_path(anchor: "reading-#{@reading.id}")
  end

  def add
    @book = Reading.find(params[:id]).book
    # redirect_to new_book_reading_path(@reading)
    @reading = Reading.new(user_id: current_user.id, book_id: @book.id)
    @reading.save!
    redirect_to book_readings_path(@reading.book_id)
  end

  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy
    redirect_to books_path
  end

  private

  def reading_params
    params.require(:reading).permit(:read_status, :start_date, :end_date, :user_rating, :cheers)
  end
end
