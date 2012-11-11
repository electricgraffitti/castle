# == Schema Information
#
# Table name: user_interactive_products
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserInteractiveProduct < ActiveRecord::Base

	validates :user_id, :product_id, presence: true

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"	
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"

  def self.create_user_interactive_products(params, user)
    if params[:interactive_product]
      if user.interactive_product
        user.user_interactive_products.first.product_id = params[:interactive_product][:product_id]
    	else
        self.create(product_id: params[:interactive_product][:product_id], user_id: user.id)
    	end
    end
  end

end
