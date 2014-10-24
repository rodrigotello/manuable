class PremiumUser < ActiveRecord::Base
	belongs_to :user
	has_one :premium_user_data, dependent: :destroy #This line doesn't make sense and I don't know why it should even be working.
end
