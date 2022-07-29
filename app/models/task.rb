class Task < ApplicationRecord
  belongs_to :user
  paginates_per 10
  scope :index_all, -> {
    select(:id, :title, :content, :deadline, :status, :user_id)
    .includes(:user)
  }
end
