class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to reading_path(@book)
    else
      render :new
    end
  end
  # do we need update/create?

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :ISBN, :author, :pages, :category, :poster_url, :description, :publisher, :publishing_date, :google_link, :rating, :rating_count)
  end

end
