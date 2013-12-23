module ApplicationHelper
  def div_image url, options={}, &block
    style = "background-image: url(#{url});"
    options[:style] = style + options[:style].to_s
    content_tag 'div', nil, options, &block
  end

  def aware_date date, &block
    if date.year == DateTime.now.year
      if date.day == DateTime.now.day && date.month == DateTime.now.month
        date_output = I18n.l(date, :format => :time)
      else
        date_output = I18n.l(date, :format => :day_month)
      end
    else
      date_output = I18n.l(date, :format => :month_year)
    end
    if block_given?
      capture(date_output, &block)
    else
      date_output
    end
  end

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

  #def div_image *args
    #options = args.extract_options!
    #options['class'] = "div-image #{options['class']||options[:class]}"
    #options['style'] = "background-image: url(#{args.shift});#{options['style']||options[:style]}"
    #content_tag :div, nil, options
  #end
end
