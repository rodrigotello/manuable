class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :sort
  belongs_to :parent_category, foreign_key: 'parent_id', class_name: 'Category'
end
