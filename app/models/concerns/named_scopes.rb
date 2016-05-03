# Provide in named classes to allow alphabetical sorting
module NamedScopes
  def self.included(base)
    base.class_eval do
      scope :alphabetical, ->() { order(:name) }
    end
  end
end
