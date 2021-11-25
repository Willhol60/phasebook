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

  def books_read
    total = 0
    readings.each do |reading|
      total += 1 unless reading.read_status == 'Future'
    end
    return total
  end

  def time_spent
    time = 0
    readings.each do |reading|
      duration = (reading.end_date - reading.start_date).to_i
      time += duration
    end
    return time
  end

  def avg_speed
    time_spent / books_read
  end
end
