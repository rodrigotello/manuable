module ProductsHelper
  def product_image_tag(attachment, size=:small, html_options={})
    if attachment.new_record?
      image_tag "", { class: "product-image", data: { src: attachment.attachment.url(size) } }.merge(html_options)
    else
      image_tag attachment.attachment.url(size), { class: "product-image", id: "product-image-#{attachment.id}" }.merge(html_options)
    end
  end

  def hashify prop_list
    prop_list.map { |t| "##{t}" }
  end
end
