class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy assign ]
  before_action :ensure_user, only: %i[ edit update destroy assign ]
  before_action :authenticate_user!

  def index
    @incomplete_tasks = Task.index_all.where.not(status: "完了").page(params[:page])
  end

  def complete_tasks
    @complete_tasks = Task.index_all.where(status: "完了").page(params[:page])
  end

  def show
    @comments = @task.comments.includes(user: { icon_attachment: :blob }).page(params[:page])
    @comment = Comment.new
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id #タスクを作成した人 = 現在ログインしているユーザー
    if @task.save!
      redirect_to task_url(@task), notice: t("flash.create", model: "タスク")
    end

  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
  end

  def assign
  end

  def update
    if @task.update!(task_params)
      redirect_to task_url(@task), notice: t("flash.update", model: "タスク")
    end

  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: t("flash.destroy", model: "タスク") }
      format.json { head :no_content }
    end
  end

  private

    def ensure_user
      @tasks = current_user.tasks
      redirect_to tasks_url, alert: t("flash.unauthorized") unless @tasks.exists?(id: params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to tasks_url, alert: t("flash.not_exits", model: "タスク")
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :deadline, :status, :user_id, :priority)
    end
end
