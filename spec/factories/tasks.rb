FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "タスク#{n}" }
    content { "テストタスク" }
    deadline { 1.week.from_now }
    status { "未対応" }
    priority { 0 }
    association :user
  end
end
