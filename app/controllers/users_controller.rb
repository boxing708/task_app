class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]
  def index
    @users = User.with_attached_icon
  end

  def show
  end

  def mypage
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end