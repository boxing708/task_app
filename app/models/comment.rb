class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  validates :content, presence: true, length: { maximum: 255 }
  paginates_per 10
end
