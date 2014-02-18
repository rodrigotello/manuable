includes ||= []
json.partial! '/api/users/show', user: @user

if includes.include? :products
  json.products @user.products, partial: '/api/products/show', as: :product, includes: [:attachments]
end

