require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "sendmail_task" do
    mail = NoticeMailer.sendmail_task
    assert_equal "Sendmail task", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
