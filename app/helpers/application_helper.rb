module ApplicationHelper

  def js_flash_notice(text)
    j(content_tag(:p, :class => 'alert alert-info') do
      text
    end)
  end
end
