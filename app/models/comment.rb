class Comment < ApplicationRecord
  belongs_to :session
  belongs_to :user

  validates :content, presence: true
end
