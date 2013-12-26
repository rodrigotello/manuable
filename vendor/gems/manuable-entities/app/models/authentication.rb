class Authentication < ActiveRecord::Base
  # attr_accessible :provider, :uuid
  belongs_to :user
end
