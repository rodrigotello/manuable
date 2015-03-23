class PremiumUser < ActiveRecord::Base
	belongs_to :user
	has_one :premium_user_data, dependent: :destroy #This line doesn't make sense and I don't know why it should even be working.

	after_create :brand_setup

	def brand_setup
		self.create_brand brand: "", address1: "", address2: "", neighborhood: "", zip: 0, city: 0, state: 0, mobile_phone: 0, local_phone: 0, email: "", facebook: "", twitter: "", instagram: "", youtbe: "", tumblr: "", pinterest: ""
	end
end