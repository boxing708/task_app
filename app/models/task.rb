class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 36 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :deadline, presence: true
  validates :status, presence: true
  paginates_per 10
  scope :index_all, -> {
    select(:id, :title, :content, :deadline, :status, :user_id)
    .includes(:user)
  }
  belongs_to :user
  has_many :comments, dependent: :destroy
end
