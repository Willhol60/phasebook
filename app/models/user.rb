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

  def books_read
    total = 0
    readings.each do |reading|
      total += 1 unless reading.read_status == 'Future'
    end
    return total
  end
end
