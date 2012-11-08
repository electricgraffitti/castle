# == Schema Information
#
# Table name: user_dependent_products
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserDependentProduct < ActiveRecord::Base

	validates :user_id, :product_id, presence: true

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"	
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"

  def self.create_user_dependent_products(params, user)
  	if params[:dependent_product]
	  	params[:dependent_product].each do |dependent_product|
	      op = self.create(product_id: dependent_product[1]['product_id'], user_id: user.id)
	    end
  	end
  end

end
