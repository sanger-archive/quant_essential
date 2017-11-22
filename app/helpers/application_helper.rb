# frozen_string_literal: true

#
# Module ApplicationHelper provides a number of helpers to assist with
# shared view components throughout the application
#
module ApplicationHelper
  #
  # Generates the page subtitle from the controller action is not specifically defined
  #
  # @return [String] A page subtitle. Eg. new, edit, index
  #
  def page_subtitle
    @subtitle || t(:subtitle, scope: [controller_name, action_name], default: action_name.titleize)
  end

  #
  # Yields if help text is available for the page
  #
  #
  # @return [void]
  def with_help?
    yield if I18n.exists?([controller_name, action_name, :help_html])
  end

  #
  # The help text for the page.
  #
  #
  # @return [String] Html safe help text.
  #
  def help_body
    t(:help_html, scope: [controller_name, action_name])
  end

  #
  # Bootstrap compatible pagination
  #
  # @param [ActiveRecord_Relation] collection A paginated association
  #
  # @return [String] A page navigation element
  #
  def pagination(collection)
    will_paginate collection, renderer: BootstrapPagination::Rails, previous_label: '&laquo;', next_label: '&raquo;'
  end

  #
  # Renders any flashes in the current session
  #
  # @return [String] A fiv containing any messages or warnings.
  #
  def render_flashes
    flash.each do |type, messages|
      content_tag(:div, class: "alert alert-#{flash_to_bootstrap(type)}") do
        content_tag(:strong, t(:title, scope: [:flashes, type], default: %i[flashes default title])) <<
          content_tag(:ul, messages.map { |m| content_tag(:li, m) })
      end
    end
  end

  private

  def flash_to_bootstrap(flash_category)
    {
      'alert' => 'danger',
      'notice' => 'success'
    }.fetch(flash_category, 'info')
  end
end
