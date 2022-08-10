class NoticeMailer < ApplicationMailer
  def sendmail_task(task)
    @task = task
    mail to: task.user.email, subject: "タスクがアサインされました"
  end
end
