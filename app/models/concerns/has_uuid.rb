# frozen_string_literal: true

module HasUuid
  def self.included(base)
    base.class_eval do
      validates_presence_of :uuid
      before_validation :assign_uuid
    end
  end

  def assign_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def friendly_uuid
    uuid.to_i.to_s(36)
  end
end
