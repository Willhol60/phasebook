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
end
