require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = User.create(
      name: "Naoya",
      email: "naoya@naoya.com",
      password: "naoya0305",
      password_confirmation: "naoya0305"
    )

    @task = @user.tasks.create(
      title: "タスク1",
      content: "タスク1の内容",
      deadline: "2022/09/08",
      status: "未対応",
      priority: 0,
    )
  end

  it "タイトル、内容、期限、ステータスがあれば有効なこと" do
    expect(@task).to be_valid
  end

  it "優先度の翻訳ができていること" do
    expect(@task.translate_priority).to eq "低"
  end
end
