class NoticeMailer < ApplicationMailer
  def sendmail_task(task)
    @task = task #インスタンス変数に代入
    mail to: "naoya.shishikura@super-studio.jp", subject: "新規タスクが作成されました"
  end
end
