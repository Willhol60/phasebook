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
      render :new
    end
  end

  # def edit
  # end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)

    respond_to do |format|
      format.html { redirect_to book_readings_path(anchor: "comment-#{@comment.id}") }
      # format.text
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to book_readings_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
