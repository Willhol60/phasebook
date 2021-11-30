require 'open-uri'
require 'json'

class BooksController < ApplicationController
  before_action :user_signed_in?, only: [:create, :random]
  def index
    @books = Book.all.reorder(updated_at: :desc)

  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @reading = Reading.new
    if @book.save!
      redirect_to books_path
    else
      render :new
    end
    @reading.book = @book
    @reading.user = current_user
    @reading.save
  end

  def search
    @query = params[:query]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{@query}"
    open_file = URI.open(url).read
    read_books = JSON.parse(open_file)
    @books = read_books['items']
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def random
    url = "https://www.googleapis.com/books/v1/volumes?q=#{current_user.randomise}"
    open_file = URI.open(url).read
    read_books = JSON.parse(open_file)
    random_book = read_books['items'][rand(0...10)]
    hash = random_book_hash(random_book)
    @book = Book.new(hash)
    @book.save!
    @reading = Reading.new(book_id: @book.id, user_id: current_user.id)
    @reading.save
    redirect_to request.referrer
  end


  private

  def book_params
    params.require(:book).permit(:title, :ISBN, :author, :pages, :category, :poster_url, :description, :publisher, :publishing_date, :google_link, :rating, :rating_count)
  end

  def random_book_hash(book)
    title = book['volumeInfo']['title'] ? book['volumeInfo']['title'] : "No title"
    poster_url = book['volumeInfo']['imageLinks'] ? book['volumeInfo']['imageLinks']['thumbnail'] : "placeholder.jpg"
    author = book['volumeInfo']['authors'] ? book['volumeInfo']['authors'].first : "Unknown Author"
    publisher = book['volumeInfo']['publisher'] || "Unknown publisher"
    pages = book['volumeInfo']['pageCount'] || 100
    category = book['volumeInfo']['categories'] ? book['volumeInfo']['categories'].first : "No category"
    if book['volumeInfo']['industryIdentifiers'] && book['volumeInfo']['industryIdentifiers'][0]['type'].include?('ISBN')
      isban = book['volumeInfo']['industryIdentifiers'][0]['identifier']
    else
      isban = "No ISBN"
    end
    description = book['volumeInfo']['description'] || "No description"
    google_link = book['volumeInfo']['previewLink'] || "www.google.com"
    rating = book['volumeInfo']['averageRating'] || 0
    rating_count = book['volumeInfo']['ratingsCount'] || 0
    { title: title,
      author: author,
      poster_url: poster_url,
      publisher: publisher,
      ISBN: isban,
      pages: pages,
      category: category,
      description: description,
      google_link: google_link,
      rating: rating,
      rating_count: rating_count
    }
  end

end
