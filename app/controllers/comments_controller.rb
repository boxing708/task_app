class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save!
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @task = Task.find(params[:task_id])
    @comment = @task.comments.find(params[:id])
    @comment.destroy
    redirect_to @task, status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :task_id)
  end
end
