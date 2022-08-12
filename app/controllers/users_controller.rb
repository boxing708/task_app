class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]
  before_action :authenticate_user!
  def index
    @users = User.with_attached_icon
  end

  def show
  end

  def mypage
  end

  def mytask
    @incomplete_tasks = current_user.tasks.where.not(status: "完了").page(params[:page])
  end

  def complete_mytasks
    @complete_tasks = current_user.tasks.where(status: "完了").page(params[:page])
  end

  private

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to users_url, alert: t("flash.unauthorized")
    end
end
