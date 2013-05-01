module ProductsHelper
  def product_image_tag(attachment, size=:small, html_options={})
    if attachment.new_record?
      image_tag "", { class: "product-image product-image-#{size}", data: { src: attachment.attachment.url(size) } }.merge(html_options)
    else
      content_tag :div, '', { style: "background-image: url(#{attachment.attachment.url(size)})", class: "product-image product-image-#{size}", id: "product-image-#{attachment.id}" }.merge(html_options)
    end
  end

  def hashify prop_list
    prop_list.map { |t| "##{t}" }
  end
end
