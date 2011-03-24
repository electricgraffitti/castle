class Notifier < ActionMailer::Base

  def support_notification(sender)
    @sender = sender
    mail(:to => "support@cube2media.com", 
         :from => sender.email,
         :subject => "New #{sender.support_type}")
  end
end


