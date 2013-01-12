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
    "#{current_user.first_name} #{current_user.last_name}"
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
