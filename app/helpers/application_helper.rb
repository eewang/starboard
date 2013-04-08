module ApplicationHelper

  def js_flash_notice(text)
    j(content_tag(:p, :class => 'error') do
      text
    end)
  end
end
