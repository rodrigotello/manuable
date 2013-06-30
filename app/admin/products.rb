ActiveAdmin.register Product do
  menu priority: 2

  show do |product|
    attributes_table do
      row :name
      row :price
      row :about
      row :prop_list
      row :amount
      row :category do
        product.category.try :name
      end
      row :attachments do
        product.attachments.collect do |a|
          image_tag(a.attachment.url(:small))
        end.join.html_safe
      end
      row :user do
        link_to product.user.name, product.user
      end
    end
  end

end
