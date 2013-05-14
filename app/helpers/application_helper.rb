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
end
