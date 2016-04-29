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

end
