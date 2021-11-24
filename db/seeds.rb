# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# loading and destroying
User.destroy_all
Book.destroy_all

require 'open-uri'
require 'json'

# loading api url
tolkein_url = 'https://www.googleapis.com/books/v1/volumes?q=tolkein'
star_wars_url = 'https://www.googleapis.com/books/v1/volumes?q=star+wars'

# creating 2 users
rami = User.new({ first_name: 'Rami', last_name: 'Assaf',
                  email: 'rami@email.org', password: 'password',
                  profile_image: 'gandalf.jpg' })
rami.save

simon = User.new({ first_name: 'Simon', last_name: 'Foster',
                   email: 'simon@email.org', password: 'password',
                   profile_image: 'vader.jpg' })
simon.save

# creating books lists
tolkein_file = URI.open(tolkein_url).read
tolkein_books = JSON.parse(tolkein_file)
t_array = tolkein_books['items']

star_wars_file = URI.open(star_wars_url).read
star_wars_books = JSON.parse(star_wars_file)
sw_array = star_wars_books['items']

sw_array.each do |book|
  title = book['volumeInfo']['subtitle'] ? "#{book['volumeInfo']['title']}: #{book['volumeInfo']['subtitle']}" : book['volumeInfo']['title']
  puts book['volumeInfo']['categories']
  this_book = Book.new({  title: title,
                          ISBN: book['volumeInfo']['industryIdentifiers'][0]['identifier'],
                          author: book['volumeInfo']['authors'].first,
                          pages: book['volumeInfo']['pageCount'],

                          poster_url: book['volumeInfo']['imageLinks']['thumbnail'],
                          description: book['volumeInfo']['description'],
                          publisher: book['volumeInfo']['publisher'],
                          publishing_date: book['volumeInfo']['publishedDate'],
                          google_link: book['volumeInfo']['previewLink'],
                          rating: book['volumeInfo']['averageRating'],
                          rating_count: book['volumeInfo']['ratingsCount'] })
  this_book.save
end

t_array.each do |book|
  title = book['volumeInfo']['subtitle'] ? "#{book['volumeInfo']['title']}: #{book['volumeInfo']['subtitle']}" : book['volumeInfo']['title']
  this_book = Book.new({  title: title,
                          ISBN: book['volumeInfo']['industryIdentifiers'][0]['identifier'],
                          author: book['volumeInfo']['authors'].first,
                          pages: book['volumeInfo']['pageCount'],

                          poster_url: book['volumeInfo']['imageLinks']['thumbnail'],
                          description: book['volumeInfo']['description'],
                          publisher: book['volumeInfo']['publisher'],
                          publishing_date: book['volumeInfo']['publishedDate'],
                          google_link: book['volumeInfo']['previewLink'],
                          rating: book['volumeInfo']['averageRating'],
                          rating_count: book['volumeInfo']['ratingsCount'] })
  this_book.save
end

# create reading sessions
Book.all.ids.each do |id|
  reed = Reading.new(user_id: User.all.ids.sample,
                     book_id: id,
                     read_status: ['Finished', 'Future'].sample)
  reed.save
end

# creating comments
10.times do
  bla = Comment.create(reading_id: Reading.all.ids.sample,
                       user_id: User.all.ids.sample,
                       content: %w[cool nice great brilliant shite loser unlucky congratulations loveya].sample)
  bla.save
end
