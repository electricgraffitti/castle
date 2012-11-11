class Notifier < ActionMailer::Base

  def support_notification(sender)
    @sender = sender
    mail(:to => "#{APP["order_email"]}", 
         :from => sender.email,
         :subject => "New #{sender.support_type}")
  end

  def user_dash_contact_request(user, params)
    @user = user
    @comments = params[:contact_submission]

    mail(:to => "#{APP["order_email"]}", 
     :from => user.email,
     :subject => "User Support Request")
  end

  def send_product_locations(user, params)

    @user = user
    @params = params

    mail(:to => "#{APP["order_email"]}", 
     :from => user.email,
     :subject => "User Support Request")
  end
  
  def successful_order_admin(order, cart, user)
    
    @order = order
    @package = Package.find(cart.package_id)
    @items = cart.items
    @user = user 
    
    mail(
      :to => "#{APP["order_email"]}",
      :from => "Castle Protection Order Transaction",
      :subject => "Castle Protection Order Submission")
  end
  
  def successful_order_customer(order, cart, user)
    
    @order = order
    @package = Package.find(cart.package_id)
    @items = cart.items
    
    mail(
      :to => "#{user.email}, #{APP["order_email"]}",
      :from => "Castle Protection",
      :subject => "Your Castle Protection Order Details")
  end

  def successful_update_order_admin(order, cart, user)
    
    @order = order
    @package = Package.find(cart.package_id)
    @items = cart.items
    @user = user 
    
    mail(
      :to => "#{APP["order_email"]}",
      :from => "Castle Protection Order Transaction",
      :subject => "Castle Protection Order Submission")
  end
  
  def successful_update_order_customer(order, cart, user)
    
    @order = order
    @package = Package.find(cart.package_id)
    @items = cart.items
    
    mail(
      :to => "#{user.email}, #{APP["order_email"]}",
      :from => "Castle Protection",
      :subject => "Your Castle Protection Order Details")
  end
  
end


