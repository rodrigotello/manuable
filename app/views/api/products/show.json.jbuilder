json.partial! '/api/products/show', product: @product, includes: [:user, :attachments, :category]
