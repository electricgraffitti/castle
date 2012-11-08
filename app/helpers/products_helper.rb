module ProductsHelper

	def not_user_dependent_product(sys)
		!user_dependent_product(sys.product)
	end

	def user_dependent_product(product)
		current_user && current_user.dependent_products.include?(product) ? true : false
	end

	def product_meets_dependency_requirements(product)
		user_dependent_product(product) || product_is_existing_interactive_product?(product)
	end

	def product_is_existing_interactive_product?(product)
		current_user && current_user.has_existing_interactive_product? && product.interactive_service
	end

	def category1(sys)
		(sys.product.monitoring_addon && sys.product.category1) ? true : false
	end

	def category2(sys)
		sys.product.category2 ? true : false
	end

	def category3(sys)
		sys.product.category3 ? true : false
	end

	def category4(sys)
		sys.product.category4 ? true : false
	end

	def category5(sys)
		(sys.product.category5) ? true : false
	end			


end
