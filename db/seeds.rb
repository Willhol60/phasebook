# loading and destroying
User.destroy_all
Book.destroy_all

require 'open-uri'
require 'json'

# loading api url
heming_url = 'https://www.googleapis.com/books/v1/volumes?q=biography'
beatrix_url = 'https://www.googleapis.com/books/v1/volumes?q=maya+angelou'
harry_url = 'https://www.googleapis.com/books/v1/volumes?q=neil+gaiman'
lady_url = 'https://www.googleapis.com/books/v1/volumes?q=leo+tolstoy'
peter_url = 'https://www.googleapis.com/books/v1/volumes?q=harry+potter'

# creating 2 users
rami = User.new({ first_name: 'Rami', last_name: 'Assaf',
                  email: 'rami@email.org', password: 'password',
                  profile_image: 'rami.jpg' })
rami.save

simon = User.new({ first_name: 'Simon', last_name: 'Foster',
                   email: 'simon@email.org', password: 'password',
                   profile_image: 'simon.jpg' })
simon.save

will = User.new({ first_name: 'Will', last_name: 'Holmes',
                  email: 'will@email.org', password: 'password',
                  profile_image: 'will-selfie.jpg' })
will.save
# mark this for mark
idris = User.new({ first_name: 'Idris', last_name: 'Elba',
                   email: 'idris@email.org', password: 'password',
                   profile_image: 'idris.jpg' })
idris.save
##
george = User.new({ first_name: 'George', last_name: 'Clooney',
                    email: 'gclooney@email.org', password: 'password',
                    profile_image: 'clooney.jpg' })
george.save

dua = User.new({ first_name: 'Dua', last_name: 'Lipa',
                 email: 'dua@email.org', password: 'password',
                 profile_image: 'dua.jpg' })
dua.save

jolie = User.new({ first_name: 'Angelina', last_name: 'Jolie',
                   email: 'jolie@email.org', password: 'password',
                   profile_image: 'jolie.jpg' })
jolie.save

# creating books lists
beatrix_books = JSON.parse(URI.open(beatrix_url).read)
beatrix_array = beatrix_books['items']

heming_books = JSON.parse(URI.open(heming_url).read)
heming_array = heming_books['items']

harry_books = JSON.parse(URI.open(harry_url).read)
harry_array = harry_books['items']

lady_books = JSON.parse(URI.open(lady_url).read)
lady_array = lady_books['items']

peter_books = JSON.parse(URI.open(peter_url).read)
peter_array = peter_books['items']

books_array = beatrix_array | heming_array | harry_array | lady_array | peter_array

# book block to check on api
def book_hash(title, isban, author, pages, poster_url, description, publisher, publishing_date, google_link, rating, rating_count, category)
  hash = { title: title,
           ISBN: isban,
           author: author,
           pages: pages,
           poster_url: poster_url,
           description: description,
           publisher: publisher,
           publishing_date: publishing_date,
           google_link: google_link,
           rating: rating,
           rating_count: rating_count,
           category: category }
  return hash
end

def paramiterised(book)
  title = book['volumeInfo']['title'] || "No title"
  poster_url = book['volumeInfo']['imageLinks'] ? book['volumeInfo']['imageLinks']['thumbnail'] : "placeholder.jpg"
  author = book['volumeInfo']['authors'] ? book['volumeInfo']['authors'].first : "Unknown Author"
  publisher = book['volumeInfo']['publisher'] || "Unknown publisher"
  pages = book['volumeInfo']['pageCount'] || 100
  if book['volumeInfo']['industryIdentifiers'] && book['volumeInfo']['industryIdentifiers'][0]['type'].include?('ISBN')
    isban = book['volumeInfo']['industryIdentifiers'][0]['identifier']
  else
    isban = "No ISBN"
  end
  description = book['volumeInfo']['description'] || "No description"
  google_link = book['volumeInfo']['previewLink'] || "www.google.com"
  rating = book['volumeInfo']['averageRating'] || 0
  rating_count = book['volumeInfo']['ratingsCount'] || 0
  category = (book['volumeInfo']['categories'] || ["No category"]).first
  publishing_date = book['volumeInfo']['publishedDate'] || Date.new(1970, 1, 1)
  return book_hash(title, isban, author, pages, poster_url, description, publisher, publishing_date, google_link, rating, rating_count, category)
end

# seeding books
books_array.each do |book|
  this_book = Book.new(paramiterised(book))
  this_book.save!
end

# create reading sessions
Book.all.ids.each do |id|
  # users = User.where(first_name: 'Jeremy').or(User.where(first_name: 'Jemima').or(User.where(first_name: 'Mrs Tiggy').or(User.where(first_name: 'Squirrel'))))
  reading = Reading.new(user_id: User.all.ids.sample,
                        book_id: id,
                        read_status: ['Finished', 'Future'].sample)
  if reading.read_status == 'Finished'
    reading.end_date = Date.today - rand(20)
    reading.start_date = reading.end_date - rand(20)
    reading.cheers = rand(15)
    reading.user_rating = rand(5)
  end
  reading.save!
end

# creating comments
15.times do
  readings = Reading.where(read_status: 'Finished')
  content = ["Cool book", "How was it?", "Great read!", "My favourite author", "Not a fan", "I didn't like the characters"]
  comment = Comment.new(reading_id: readings.ids.sample,
                        user_id: User.all.ids.sample,
                        content: content.sample)
  comment.save!
end
