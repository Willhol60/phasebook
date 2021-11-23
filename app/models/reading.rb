class Reading < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  validates :read_status, inclusion: { in: ['Finished', 'Current', 'Future'] }
  # validates_inclusion_of :user_rating, in: 1..5
end
