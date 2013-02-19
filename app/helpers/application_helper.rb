module ApplicationHelper
  
  def page_title(page_title)
    content_for(:title) { page_title }
  end
  
  def meta_keywords(meta_keywords)
    content_for(:keywords) {meta_keywords}
  end
  
  def meta_description(meta_description)
    content_for(:description) {meta_description}
  end

  def clear
  	content_tag(:div, "", :class => "clear")
  end

  def separator
    content_tag(:div, '', class: "separator")
  end

  def user_name
    "#{current_user.first_name} #{current_user.last_name}" if current_user
  end

  def user_stripe_id
    current_user.stripe_id
  end

  def user_email
    current_user.email
  end

  def user_phone
    current_user.phone
  end

  def billing_address
    current_user.billing_record.address
  end

  def billing_city
    current_user.billing_record.city
  end

  def billing_state
    current_user.billing_record.state.full_name
  end

  def billing_zip
    current_user.billing_record.billing_zip
  end      

  def location_address
    current_user.additional_service_record.secondary_address
  end

  def location_city
    current_user.additional_service_record.secondary_city
  end

  def location_state
    current_user.additional_service_record.state.full_name
  end

  def location_zip
    current_user.additional_service_record.secondary_zip
  end

  def secondary_phone
    current_user.additional_service_record.secondary_phone
  end
  
  def subdivision
    current_user.additional_service_record.subdivision
  end

  def cross_street
    current_user.additional_service_record.cross_street
  end

  def emergency_name
    current_user.additional_service_record.emergency_name
  end

  def emergency_password
    current_user.additional_service_record.emergency_password
  end

  def permit_info
    current_user.additional_service_record.permit_info
  end


  def total_setup_charge(cart)
    number_to_currency((cart.total_price * 2) + APP["process_fee"])
  end

  def cart_monthly_rate(cart)
    number_to_currency(cart.total_price)
  end

  def add_cart_rate(cart)
    number_to_currency(current_user.monthly_rate + cart.total_price)
    # number_to_currency((current_user.monthly_rate + cart.total_price) + ((current_user.monthly_rate + cart.total_price) * APP['tax_rate']))
  end

  def addon_monthly_rate
    @monthly_rate = @monthly_rate || "Current Monthly Rate: " + number_to_currency(current_user.monthly_rate)
  end

  def monthly_rate
    "Current Monthly Rate: " + number_to_currency(current_user.monthly_rate)
  end

  def invoice_amount(invoice)
    number_to_currency(Currency.calculate_cents_to_dollars(invoice.total))
  end

  def unassigned_products(order_products)
    OrderProduct.unassigned_items(order_products).length > 0 ? true : false
  end

  def assigned_products(order_products)
    OrderProduct.assigned_items(order_products).length > 0 ? true : false
  end

  def finalized_items(order_products)
    OrderProduct.finalized_items(order_products).length > 0 ? true : false
  end

  def login_logout_link
    if current_user
      link_to "Logout", logout_path
    else
      link_to "Login", login_path
    end
  end

end
