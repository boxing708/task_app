class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :deadline, presence: true
  validates :status, presence: true
  belongs_to :user
  paginates_per 10
  scope :index_all, -> {
    select(:id, :title, :content, :deadline, :status, :user_id)
    .includes(:user)
  }
end
