require 'open-uri'
require 'json'

class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def search
    @query = params[:query]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{@query}"
    open_file = URI.open(url).read
    read_books = JSON.parse(open_file)
    @books = read_books['items']
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
