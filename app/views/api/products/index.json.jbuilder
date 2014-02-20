json.partial! '/api/products/show', collection: @products, as: :product, includes: [:user, :attachments, :category]
