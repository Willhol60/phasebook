class Book < ApplicationRecord
  has_many :readings, dependent: :destroy
  has_many :users, through: :readings
end
