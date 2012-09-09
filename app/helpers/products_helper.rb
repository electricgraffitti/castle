module ProductsHelper

	def category1(sys)
		(sys.product.monitoring_addon && sys.product.category1) ? true : false
	end

	def category2(sys)
		sys.product.category2 ? true : false
		# if sys.product.category2
		# 	sys.product.monitoring_addon || sys.product.dependent_item ? false : true
		# else
		# 	return false
		# end
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
