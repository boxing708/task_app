class CommentsController < ApplicationController

  COMMENT = "コメント"

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save!
      redirect_back(fallback_location: root_path,
      notice: t('flash.create', model: COMMENT))
    end

  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.record.errors.full_messages.join("\n")
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @task = Task.find(params[:task_id])
    @comment = @task.comments.find(params[:id])
    @comment.destroy
    redirect_to @task, status: :see_other,
    notice: t('flash.destroy', model: COMMENT)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :task_id)
  end
end
