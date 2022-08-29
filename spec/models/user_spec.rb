require 'rails_helper'

RSpec.describe User, type: :model do
  it "メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      email: "naoya@naoya.com",
      password: "naoya0305",
    )
    expect(user).to be_valid
  end

  it "メールがなければ無効な状態であること" do
    user = User.new(
      email: nil
    )
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "パスワードがなければ無効な状態であること" do
    user = User.new(
      password: nil
    )
    user.valid?
    expect(user.errors[:password]).to include("が入力されていません。")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    user = User.create(
      name: "Naoya",
      email: "naoya@naoya.com",
      password: "naoya0305",
      password_confirmation: "naoya0305"
    )
    # user.confirm

    user = User.new(
      name: "Test",
      email: "naoya@naoya.com",
      password: "naoya0305",
      password_confirmation: "naoya0305"
    )

    user.valid?
    expect(user.errors[:email]).to include("は既に使用されています。")
  end
end
