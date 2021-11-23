class Comment < ApplicationRecord
  belongs_to :reading
  belongs_to :user

  validates :content, presence: true
end
