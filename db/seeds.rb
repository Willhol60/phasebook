# loading and destroying
User.destroy_all
Book.destroy_all

require 'open-uri'
require 'json'

# loading api url
fifty_url = 'https://www.googleapis.com/books/v1/volumes?q=fifty+shades'
beatrix_url = 'https://www.googleapis.com/books/v1/volumes?q=beatrix'
bad_url = 'https://www.googleapis.com/books/v1/volumes?q=bad+behavior'
lady_url = 'https://www.googleapis.com/books/v1/volumes?q=lady+chat'
peter_url = 'https://www.googleapis.com/books/v1/volumes?q=peter+rabbit'

# creating 2 users
rami = User.new({ first_name: 'Rami', last_name: 'Assaf',
                  email: 'rami@email.org', password: 'password',
                  profile_image: 'gandalf.jpg' })
rami.save

simon = User.new({ first_name: 'Simon', last_name: 'Foster',
                   email: 'simon@email.org', password: 'password',
                   profile_image: 'vader.jpg' })
simon.save

will = User.new({ first_name: 'Will', last_name: 'Holmes',
                  email: 'will@email.org', password: 'password',
                  profile_image: 'selfie.jpeg' })
will.save

jeremy = User.new({ first_name: 'Jeremy', last_name: 'Fisher',
                    email: 'jeremy@email.org', password: 'password',
                    profile_image: 'jeremy.png' })
jeremy.save

jemima = User.new({ first_name: 'Jemima', last_name: 'Puddle-Duck',
                    email: 'jemima@email.org', password: 'password',
                    profile_image: 'jemima.jpg' })
jemima.save

tiggy = User.new({ first_name: 'Mrs Tiggy', last_name: 'Winkle',
                   email: 'tiggy@email.org', password: 'password',
                   profile_image: 'tiggy.jpg' })
tiggy.save

squirrel = User.new({ first_name: 'Squirrel', last_name: 'Nutkin',
                      email: 'squirrel@email.org', password: 'password',
                      profile_image: 'squirrel.jpg' })
squirrel.save

# creating books lists
beatrix_books = JSON.parse(URI.open(beatrix_url).read)
beatrix_array = beatrix_books['items']

fifty_books = JSON.parse(URI.open(fifty_url).read)
fifty_array = fifty_books['items']

bad_books = JSON.parse(URI.open(bad_url).read)
bad_array = bad_books['items']

lady_books = JSON.parse(URI.open(lady_url).read)
lady_array = lady_books['items']

peter_books = JSON.parse(URI.open(peter_url).read)
peter_array = peter_books['items']

beatrix_array.each do |book|
  title = book['volumeInfo']['title'] ? "#{book['volumeInfo']['title']}: #{book['volumeInfo']['subtitle']}" : "No title"
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
  this_book = Book.new({  title: title,
                          ISBN: isban,
                          author: author,
                          pages: pages,
                          poster_url: poster_url,
                          description: description,
                          publisher: publisher,
                          publishing_date: book['volumeInfo']['publishedDate'],
                          google_link: google_link,
                          rating: rating,
                          rating_count: rating_count })
  this_book.category = (book['volumeInfo']['categories'] || ["No category"]).first
  this_book.save!
end

fifty_array.each do |book|
  title = book['volumeInfo']['title'] ? "#{book['volumeInfo']['title']}: #{book['volumeInfo']['subtitle']}" : "No title"
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
  this_book = Book.new({  title: title,
                          ISBN: isban,
                          author: author,
                          pages: pages,
                          poster_url: poster_url,
                          description: description,
                          publisher: publisher,
                          publishing_date: book['volumeInfo']['publishedDate'],
                          google_link: google_link,
                          rating: rating,
                          rating_count: rating_count })
  this_book.category = (book['volumeInfo']['categories'] || ["No category"]).first
  this_book.save!
end

bad_array.each do |book|
  title = book['volumeInfo']['title'] ? "#{book['volumeInfo']['title']}: #{book['volumeInfo']['subtitle']}" : "No title"
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
  this_book = Book.new({  title: title,
                          ISBN: isban,
                          author: author,
                          pages: pages,
                          poster_url: poster_url,
                          description: description,
                          publisher: publisher,
                          publishing_date: book['volumeInfo']['publishedDate'],
                          google_link: google_link,
                          rating: rating,
                          rating_count: rating_count })
  this_book.category = (book['volumeInfo']['categories'] || ["No category"]).first
  this_book.save!
end

lady_array.each do |book|
  title = book['volumeInfo']['title'] ? "#{book['volumeInfo']['title']}: #{book['volumeInfo']['subtitle']}" : "No title"
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
  this_book = Book.new({  title: title,
                          ISBN: isban,
                          author: author,
                          pages: pages,
                          poster_url: poster_url,
                          description: description,
                          publisher: publisher,
                          publishing_date: book['volumeInfo']['publishedDate'],
                          google_link: google_link,
                          rating: rating,
                          rating_count: rating_count })
  this_book.category = (book['volumeInfo']['categories'] || ["No category"]).first
  this_book.save!
end

peter_array.each do |book|
  title = book['volumeInfo']['title'] ? "#{book['volumeInfo']['title']}: #{book['volumeInfo']['subtitle']}" : "No title"
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
  this_book = Book.new({  title: title,
                          ISBN: isban,
                          author: author,
                          pages: pages,
                          poster_url: poster_url,
                          description: description,
                          publisher: publisher,
                          publishing_date: book['volumeInfo']['publishedDate'],
                          google_link: google_link,
                          rating: rating,
                          rating_count: rating_count })
  this_book.category = (book['volumeInfo']['categories'] || ["No category"]).first
  this_book.save!
end

# create reading sessions

Book.all.ids.each do |id|
  users = User.where(first_name: 'Jeremy').or(User.where(first_name: 'Jemima').or(User.where(first_name: 'Mrs Tiggy').or(User.where(first_name: 'Squirrel'))))
  reading = Reading.new(user_id: users.sample.id,
                        book_id: id,
                        read_status: ['Finished', 'Future'].sample)
  if reading.read_status == 'Finished'
    reading.end_date = Date.today - rand(10)
    reading.cheers = rand(15)
    reading.user_rating = rand(5)
  end
  reading.save!
end

# creating comments
15.times do
  readings = Reading.where(read_status: 'Finished')
  comment = Comment.new(reading_id: readings.ids.sample,
                        user_id: User.all.ids.sample,
                        content: %w[cool nice great brilliant shite loser unlucky congratulations loveya].sample)
  comment.save!
end
