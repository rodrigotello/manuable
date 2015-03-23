class Brand < ActiveRecord::Base
	belongs_to :user
	has_one :brand_story
end
