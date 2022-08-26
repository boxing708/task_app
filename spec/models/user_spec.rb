require 'rails_helper'

RSpec.describe User, type: :model do
  it "メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      email: "naoya@naoya.com",
      password: "naoya0305",
    )
    expect(user).to be_valid
  end
end
