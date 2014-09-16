class PremiumUserData < ActiveRecord::Base
	belongs_to :user
	#needs to belong to a "premium_user"
end
