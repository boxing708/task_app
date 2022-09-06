class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 36 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :deadline, presence: true
  validates :status, presence: true
  paginates_per 10
  scope :index_all, -> {
    select(:id, :title, :content, :deadline, :status, :user_id, :priority)
    .includes(:user)
  }
  belongs_to :user
  has_many :comments, dependent: :destroy
  enum priority: { low: 0, middle: 1, high: 2 }

  def translate_priority
    if self.priority == "low"
      "低"
    elsif self.priority == "middle"
      "中"
    elsif self.priority == "high"
      "高"
    end
  end

  def send_slack(user_name)
    client = Slack::Web::Client.new
    client.chat_postMessage(
      channel: '#task_app_notice',
      text: "#{user_name}さんにタスクがアサインされました:rocket:"
    )
  end
end
