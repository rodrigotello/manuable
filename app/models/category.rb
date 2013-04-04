class Category < ActiveRecord::Base
  attr_accessible :name, :value, :parent_id
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Category'
  has_many :childs, foreign_key: 'parent_id', class_name: 'Category'

  def self.masters
  	where(:parent_id => nil)
  end

 # def self.producers
  #	where(:value => 'PRODUCER')
  #end
end
