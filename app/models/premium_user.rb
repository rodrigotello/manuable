class PremiumUser < ActiveRecord::Base
	belongs_to :user
	has_one :premium_user_data, dependent: :destroy
end
