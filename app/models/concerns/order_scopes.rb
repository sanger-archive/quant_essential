# frozen_string_literal: true

# Common scopes for sorting by most recent
module OrderScopes
  def self.included(base)
    base.class_eval do
      scope :latest_first, ->() { order(id: :desc) }
    end
  end
end
