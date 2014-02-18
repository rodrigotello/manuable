includes ||= []

json.(product, :name, :price, :about, :amount, :likes_count, :id)

if includes.include?(:user)
  json.user do
    json.partial! '/api/users/show', user: product.user
  end
end

if includes.include?(:category) && product.category.present?
  json.category do
    json.name category.name
    json.id category.id
  end
end

if includes.include?(:attachments)
  json.attachments product.attachments, partial: '/api/attachments/show', as: :attachment
end
