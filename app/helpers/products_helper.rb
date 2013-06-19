module ProductsHelper

  def product_metadata product
    metas = ""
    metas << content_tag( "meta", nil, property: 'og:title', content: "#{sanitize(product.user.name)}#{ product.name.present? ? " - " + sanitize(product.name) : '' }")
    metas << content_tag( "meta", nil, property: 'og:site_name', content: "Manuable")
    metas << content_tag( "meta", nil, property: 'og:type', content: "website")
    metas << content_tag( "meta", nil, property: 'og:url', content: product_url(product))
    metas << content_tag( "meta", nil, property: 'og:description', content: sanitize(product.about))
    metas << content_tag( "meta", nil, property: 'og:image', content: product.attachments.first.attachment.url) if product.attachments.first.present?
    metas.html_safe
  end

  def product_image_tag(attachment, size=:small, html_options={})
    if attachment.new_record?
      image_tag "", { class: "product-image product-image-#{size}", data: { src: attachment.attachment.url(size) } }.merge(html_options)
    else
      content_tag :div, '', { style: "background-image: url(#{attachment.attachment.url(size)})", class: "product-image product-image-#{size}", id: "product-image-#{attachment.id}" }.merge(html_options)
    end
  end

  def hashify prop_list
    prop_list.map { |t| link_to("##{t}", root_path(tags: t)) }.join(" ").html_safe
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
