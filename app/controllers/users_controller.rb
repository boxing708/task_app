class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: %i[ mytask ]

  def index
    @users = User.with_attached_icon
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to users_url, alert: t("flash.unauthorized")
  end

  def mypage
  end

  def mytask
    @incomplete_tasks = @q.result.where(user_id: current_user.id).includes(:user).where.not(status: "完了").page(params[:page])

    @q = @incomplete_tasks.ransack(params[:q])
    @incomplete_tasks = @q.result.includes(:user).page(params[:page])
  end

  def complete_mytasks
    @complete_tasks = current_user.tasks.where(status: "完了").page(params[:page])
  end

  private

    def set_q
      @q = Task.ransack(params[:q])
    end
end
