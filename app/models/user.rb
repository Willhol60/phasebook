class User < ApplicationRecord
  has_many :readings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :books, through: :readings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  acts_as_voter
  # validates :first_name, :last_name, presence: true

  def randomise
    if readings
      readings.filter_map { |reading| reading.book.category if reading.book.category != "No category" }.uniq!.sample
    else
      ["Fiction", "Performing Arts", "Philosophy", "Biography & Autobiography", "Art"].sample
    end
  end

  def books_read
    total = 0
    readings.each { |reading| total += 1 if reading.read_status == 'Finished' }
    return total
  end

  def time_spent
    time = 0
    readings.each do |reading|
      if reading.end_date && reading.start_date && (reading.read_status == 'Finished')
        duration = (reading.end_date - reading.start_date).to_i
        time += duration
      end
    end
    return time
  end

  def avg_speed
    time_spent / books_read if time_spent && books_read && books_read.positive?
  end

  def top_categories
    Book.joins(:readings).joins(:users).where("readings.read_status = ?", "Finished").where("first_name = ?", first_name).where("category != ?", "No category").group(:category).count.sort_by {|k,v| v}.reverse[0..2].to_h
  end
end
