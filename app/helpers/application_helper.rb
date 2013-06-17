module ApplicationHelper
  def for_logging_user_only &block
    if user_signed_in?
      capture(&block)
    end
  end

  def js_data
    content_tag :script do
      "var current_user = #{current_user.to_json};".html_safe
    end
  end

  def site_metadata
    metas = ''
    metas << content_tag( "meta", nil, property: 'og:title', content: "Manuable")
    metas << content_tag( "meta", nil, property: 'og:site_name', content: "Manuable")
    metas << content_tag( "meta", nil, property: 'og:type', content: "website")
    metas << content_tag( "meta", nil, property: 'og:url', content: 'http://manuable.com')
    metas << content_tag( "meta", nil, property: 'og:description', content: 'Descubre y Comparte productos hechos a mano')
    metas << content_tag( "meta", nil, property: 'og:image', content: 'http://manuable.com/assets/logo.png')

    metas.html_safe
  end
end
