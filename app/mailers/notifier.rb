class Notifier < ActionMailer::Base

  def support_notification(sender)
    @sender = sender
    mail(:to => "#{APP["order_email"]}", 
         :from => "Castle Protection General Notification",
         :subject => "New #{sender.support_type}")
  end

  def user_dash_contact_request(user, params)
    @user = user
    @comments = params[:contact_submission]

    mail(:to => "#{APP["order_email"]}", 
     :from => "Castle Protection Customer Support Request",
     :subject => "User Support Request"
    )
  end

  def send_product_locations(user, products)

    @user = user
    @products = products

    mail(:to => "#{APP["order_email"]}", 
     :from => "Castle Protection Product Location Submissions",
     :subject => "Castle Protection Product Location Submissions")
  end

  def successful_user_update_admin(user, update_type)
    @user = user
    @update_type = update_type
    mail(
      :to => "#{APP["order_email"]}",
      :from => "Castle Protection Admin Notifier",
      :subject => "Castle Protection Updated User Record")    
  end

  def successful_user_update_customer(user, update_type)

    @user = user
    @update_type = update_type
    
    mail(
      :to => "#{user.email}, #{APP["order_email"]}",
      :from => "Castle Protection",
      :subject => "Your Castle Protection user record has been updated.")
  end  
  
  def successful_order_admin(user, cart, order)
    
    @order = order
    @price = cart.total_price
    @user = user 
    
    mail(
      :to => "#{APP["order_email"]}",
      :from => "Castle Protection Order Transaction",
      :subject => "Castle Protection Order Submission")
  end
  
  def successful_order_customer(user, cart, order, plan)
    
    @order = order
    @package = Package.find(cart.package_id)
    @items = cart.items
    @plan = plan
    @user = user
    
    mail(
      :to => "#{user.email}, #{APP["order_email"]}",
      :from => "Castle Protection",
      :subject => "Your Castle Protection Order Details")
  end

  def successful_update_order_admin(order, cart, user, old_plan, plan)
    
    @order = order
    @user = user
    @old_plan_amount = Currency.calculate_cents_to_dollars(old_plan.amount)
    @new_plan_amount = Currency.calculate_cents_to_dollars(plan.amount)
    
    mail(
      :to => "#{APP["order_email"]}",
      :from => "Castle Protection Order Transaction",
      :subject => "Castle Protection Order Submission")
  end
  
  def successful_update_order_customer(order, cart, user, old_plan, plan)
    
    @order = order
    @user = user
    @old_plan_amount = Currency.calculate_cents_to_dollars(old_plan.amount)
    @new_plan_amount = Currency.calculate_cents_to_dollars(plan.amount)
    
    mail(
      :to => "#{user.email}, #{APP["order_email"]}",
      :from => "Castle Protection",
      :subject => "Your Castle Protection Order Details")
  end
  
end


