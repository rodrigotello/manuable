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

  def heart_overlay product, liked
    content_tag :div, id: "heart-overlay-#{dom_id product}", class: "heart-overlay#{liked ? ' liked' : ''}" do
      output = ''
      output << content_tag(:div, '', class: 'fog')
      if user_signed_in?
        if !liked
          output << link_to( "<span class='likes-count'>#{product.likes_count||0}</span>".html_safe, like_product_path(product, format: 'json'), method: :post, class: "like", remote: true)
        else
          output << link_to( "<span class='likes-count'>#{product.likes_count||0}</span>".html_safe, "javascript:void(1)", class: "like")
          end
      else
        output << link_to( "<span class='likes-count'>#{product.likes_count||0}</span>".html_safe, "#sign_popup", "data-toggle" => "modal", class: "like")
      end
      output.html_safe
    end
  end
end
