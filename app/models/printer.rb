class Printer < ActiveRecord::Base

  belongs_to :label_template

  validates_presence_of :name, :label_template
  validates_uniqueness_of :name

  def template_id
    label_template.external_id
  end

  def exists_externally?
    true
  end

end
