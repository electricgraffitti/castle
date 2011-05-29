class Notifier < ActionMailer::Base

  def support_notification(sender)
    @sender = sender
    mail(:to => "support@cube2media.com", 
         :from => sender.email,
         :subject => "New #{sender.support_type}")
  end
  
  def successful_order_admin(order, tc_id, tc_recurring_id, auth, cart)
    
    @order = order
    @order_locations = @order.order_products
    @billing_info = @order.billing_records.last
    @package = Package.find(@cart.package_id)
    @items = cart.items
    @trans_id = tc_id
    @recurring_id = tc_recurring_id
    @auth = auth
    
    mail(
      :to => "support@cube2media.com", 
      :subject => "Castle Protection Order Submission")
  end
  
  def successful_order_customer(order, tc_id, tc_recurring_id, cart)
    
    @order = order
    @order_locations = @order.order_products
    @billing_info = @order.billing_records.last
    @package = Package.find(@cart.package_id)
    @items = cart.items
    @trans_id = tc_id
    @recurring_id = tc_recurring_id
    
    
    mail(
      :to => "support@cube2media.com",
      :subject => "Your Castle Protection Order Details")
  end
  
end


