class Category < ActiveRecord::Base
  # attr_accessible :name, :value, :parent_id
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Category'
  has_many :childs, foreign_key: 'parent_id', class_name: 'Category'

  has_many :products
  #has_and_belongs_to_many :products

  def self.masters
  	where(:parent_id => nil)
  end

  def self.producers
  	where(:value => 'PRODUCER').first.childs
 	end

  def self.deliverers
  	where(:value => 'DELIVER').first.childs
 	end

  def self.product_category
    where(:value => 'CATPROD').first.childs
  end

  def as_json options={}
    {
      id: id,
      name: name,
      products_count: products_count
    }
  end

end
