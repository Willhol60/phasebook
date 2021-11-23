class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.reading = params[:reading_id]
    if @comment.save
      redirect_to book_readings_path(anchor: "comment-#{@comment.id}")
    else
      render new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
