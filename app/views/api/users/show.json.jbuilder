includes ||= params[:includes] || []
json.partial! '/api/users/show', user: @user

if includes.include? :products
  json.products @user.products, partial: '/api/products/show', as: :product, includes: [:attachments]
end

if includes.include?('followees')
  json.followees do
    json.partial! '/api/users/show', collection: @user.followees, as: :user
  end
end

if includes.include?('followers')
  json.followers do
    json.partial! '/api/users/show', collection: @user.followers, as: :user
  end
end
