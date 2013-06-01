class AddAttachmentsCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :attachments_count, :integer
    Product.find_each do |p|
      Product.reset_counters p.id, :attachments
    end
  end
end
