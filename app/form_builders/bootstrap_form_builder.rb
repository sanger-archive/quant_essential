# frozen_string_literal: true

class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  GROUP_CLASS = 'form-group'
  CONTROL_CLASS = 'form-control'
  LABEL_CLASS = 'col-sm-3 control-label'
  CONTROL_DIV_CLASS = 'col-sm-9'

  def self.bootstrapify(*originals)
    originals.each do |original|
      define_method(original) do |field_name, options = {}|
        options[:class] ||= +''
        options[:class] << ' form-control'
        @template.content_tag(:div, class: GROUP_CLASS) do
          label(field_name, class: LABEL_CLASS) +

            @template.content_tag(:div, super(field_name, options), class: CONTROL_DIV_CLASS)
        end
      end
    end
  end

  bootstrapify(:number_field, :text_field, :password_field)

  def select(field_name, choices, options = {}, html_options = {})
    html_options[:class] ||= +''
    options[:prompt] ||= 'Select...'
    html_options[:class] << ' form-control'
    @template.content_tag(:div, class: GROUP_CLASS) do
      label(field_name, class: LABEL_CLASS) +

        @template.content_tag(:div, super(field_name, choices, options, html_options), class: CONTROL_DIV_CLASS)
    end
  end

  def check_box(field_name, options = {}, checked_value = '1', unchecked_value = '0')
    @template.content_tag(:div, class: GROUP_CLASS) do
      label(field_name, class: LABEL_CLASS) +
        @template.content_tag(:div, super(field_name, options, checked_value, unchecked_value), class: CONTROL_DIV_CLASS)
    end
  end

  def submit(*args)
    options = args.detect { |a| a.respond_to?(:fetch) }

    if options.nil?
      options = {}
      args << options
    end

    options && options[:class] ||= 'btn btn-default'
    @template.content_tag(:div, class: GROUP_CLASS) do
      @template.content_tag(:div, class: 'col-sm-offset-2 col-sm-10') do
        super(*args)
      end
    end
  end
end
