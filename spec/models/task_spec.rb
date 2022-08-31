require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.create(:task)
  end

  describe "バリデーションが機能していること" do
    it "タイトル、内容、期限、ステータスがあれば有効なこと" do
      expect(@task).to be_valid
    end

    it "タイトルがなければ無効な状態であること" do
      @task.title = nil
      @task.valid?
      expect(@task.errors[:title]).to include("が空になっています。入力してください。")
    end

    it "内容がなければ無効な状態であること" do
      @task.content = nil
      @task.valid?
      expect(@task.errors[:content]).to include("が空になっています。入力してください。")
    end

    it "期限がなければ無効な状態であること" do
      @task.deadline = nil
      @task.valid?
      expect(@task.errors[:deadline]).to include("が空になっています。入力してください。")
    end

    it "ステータスがなければ無効な状態であること" do
      @task.status = nil
      @task.valid?
      expect(@task.errors[:status]).to include("が空になっています。入力してください。")
    end
  end

  it "優先度の翻訳ができていること" do
    @task.priority = 0
    expect(@task.translate_priority).to eq "低"
  end
end
