class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.reading_id = params[:reading_id]
    @comment.user_id = current_user.id
    reading = @comment.reading_id
    if @comment.save
      # this will need to be changed to Stimulus auto-loading
      redirect_to book_readings_path(:book, anchor: "reading-#{reading}", reading: reading)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    reading = @comment.reading_id
    book = @comment.reading.book
    @comment.destroy
    redirect_to book_readings_path(book, anchor: "reading-#{reading}", reading: reading)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
