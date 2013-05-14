class City < ActiveRecord::Base
  attr_accessible :name, :country_id, :state_id
end
