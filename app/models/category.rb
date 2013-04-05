class Category < ActiveRecord::Base
  attr_accessible :name, :value, :parent_id
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Category'
  has_many :childs, foreign_key: 'parent_id', class_name: 'Category'

  has_and_belongs_to_many :products

  def self.masters
  	where(:parent_id => nil)
  end

  def self.producers
  	@master = where(:value => 'PRODUCER')
 		where(:parent_id => @master)
 	end

  def self.deliverers
  	@master = where(:value => 'DELIVER')
 		where(:parent_id => @master)
 	end

  def self.product_category
    @master = where(:value => 'CATPROD')
    where(:parent_id => @master)   
  end
end
