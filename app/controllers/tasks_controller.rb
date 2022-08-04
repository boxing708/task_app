class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy assign ]
  before_action :ensure_user, only: %i[ edit update destroy assign ]
  before_action :authenticate_user!

  def index
    tasks = Task.index_all
    @incomplete_tasks = tasks.where.not(status: "完了").page(params[:page])
    @complete_tasks = tasks.where(status: "完了").page(params[:page])
  end

  def show
    @comments = @task.comments.includes(:user).page(params[:page])
    @comment = Comment.new
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id #タスクを作成した人 = 現在ログインしているユーザー
    respond_to do |format|
      if @task.save
        NoticeMailer.sendmail_task(@task).deliver
        format.html { redirect_to task_url(@task), notice: "タスクが作成されました" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def assign
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "タスクが更新されました" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "タスクが削除されました" }
      format.json { head :no_content }
    end
  end

  private

    def ensure_user
      @tasks = current_user.tasks
      redirect_to tasks_url, alert: "権限がありません" unless @tasks.exists?(id: params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to tasks_url, alert: "存在しないタスクです。"
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :deadline, :status, :user_id)
    end
end
