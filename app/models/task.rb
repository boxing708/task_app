class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 36 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :deadline, presence: true
  validates :status, presence: true
  paginates_per 4
  scope :index_all, -> {
    select(:id, :title, :content, :deadline, :status, :user_id, :priority)
    .includes(:user)
  }
  belongs_to :user
  has_many :comments, dependent: :destroy
  enum priority: { low: 0, middle: 1, high: 2 }
end
