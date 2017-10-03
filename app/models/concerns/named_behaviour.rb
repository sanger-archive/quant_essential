# frozen_string_literal: true

# Provide in named classes to allow alphabetical sorting
# Also ensures that names are present and unique
module NamedBehaviour
  def self.included(base)
    base.class_eval do
      validates :name, presence: true, uniqueness: true
      scope :alphabetical, ->() { order(:name) }
    end
  end
end
