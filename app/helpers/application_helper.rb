module ApplicationHelper

  def page_subtitle
    @subtitle || t(:subtitle, scope:[controller_name,action_name],default:action_name.titleize)
  end

  def with_help?
    yield if I18n.exists?([controller_name,action_name,:help_html])
  end

  def help_body
    t(:help_html,scope:[controller_name,action_name])
  end

  def pagination(collection)
    will_paginate collection, renderer: BootstrapPagination::Rails, previous_label: "&laquo;", next_label: "&raquo;"
  end

  def render_flashes
    flash.each do |type,messages|
      content_tag(:div,:class=>"alert alert-#{flash_to_bootstrap(type)}") do
        content_tag(:strong,t(:title,scope:[:flashes,type],default:[:flashes,:default,:title])) <<
        content_tag(:ul,messages.map {|m| content_tag(:li,m) })
      end
    end
  end

  private

  def flash_to_bootstrap(flash_category)
    {
      'alert' => 'danger',
      'notice' => 'success'
    }.fetch(flash_category,'info')
  end

end
