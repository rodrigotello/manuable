json.partial! '/api/products/show', collection: @products, as: :product, includes: [:attachments, :category]
