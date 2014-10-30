module CartsHelper
	def cart_total_price
		total = 0
		current_user.carts.each do |c|
			total = total + c.product.price
			if c.shipping_boolean 
				total = total + c.product.shipping
			end
		end
		total
	end

	def premium_product
		 @premium_product = PremiumUser.where(premium_user: current_user.id)[0].nil? ? false : true
	end
end
