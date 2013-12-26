module Commontator
  module ApplicationHelper
    def javascript_proc
      Commontator.javascript_proc.call(self).html_safe
    end

    def div_image url, options={}, &block
      style = "background-image: url(#{url});"
      options[:style] = style + options[:style].to_s
      content_tag 'div', nil, options, &block
    end
  end
end
