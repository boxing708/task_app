class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy assign assign_update done ]
  before_action :ensure_user, only: %i[ edit update destroy assign ]
  before_action :set_q, only: %i[ index search done ]
  before_action :authenticate_user!

  def index
    @incomplete_tasks = @q.result.index_all.where.not(status: "完了").page(params[:page])
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

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.join("\n")
    render :new
  end

  def edit
  end

  def assign
  end

  def assign_update
    if @task.update!(task_params)
      NoticeMailer.sendmail_task(@task).deliver
      redirect_to task_url(@task), notice: "#{@task.user.name}さんにタスクがアサインされました。"
    end

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.join("\n")
    render :assign
  end

  def update
    redirect_to task_url(@task), notice: t("flash.update", model: "タスク") if @task.update!(task_params)

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.join("\n")
    render :edit
  end

  def destroy
    redirect_back fallback_location: root_path, notice: t("flash.destroy", model: "タスク") if @task.destroy!

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.join("\n")
    redirect_back fallback_location: root_path
  end

  def done
    @task.update(status: "完了")
    redirect_back(fallback_location: root_path)
  end

  def search
    @results = @q.result.includes(:user).page(params[:page])
  end

  private

    def set_q
      @q = Task.ransack(params[:q])
    end

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
