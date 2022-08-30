require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なファクトリを持つこと" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "メール、パスワードがあれば有効な状態であること" do
    user = FactoryBot.build(:user, email: "naoya@naoya.com", password: "naoya0305")
    expect(user).to be_valid
  end

  it "メールがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "パスワードがなければ無効な状態であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("が入力されていません。")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: "naoya@naoya.com")
    user = FactoryBot.build(:user, email: "naoya@naoya.com")
    user.valid?
    expect(user.errors[:email]).to include("は既に使用されています。")
  end
end
