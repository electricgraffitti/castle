class Notifier < ActionMailer::Base

  def support_notification(sender)
    @sender = sender
    mail(:to => "larry@cube2media.com", 
         :from => sender.email,
         :subject => "New #{sender.support_type}")
  end
end


