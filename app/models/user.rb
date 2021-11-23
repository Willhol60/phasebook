class User < ApplicationRecord
  has_many :readings
  has_many :comments
  has_many :books, through: :readings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # validates :first_name, :last_name, presence: true
end
