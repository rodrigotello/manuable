class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :sort
end
