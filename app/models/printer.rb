class Printer < ActiveRecord::Base
  include NamedBehaviour

  belongs_to :label_template

  validates_presence_of :label_template

  def to_param
    name
  end

  def template_id
    label_template.external_id
  end

  def exists_externally?
    Printer.external_printers.include?(name)
  end

  class << self
    def external_printers
      PMB::Printer.all.map(&:name)
    end
  end
end
