# frozen_string_literal: true

#
# Module HasUuid provides:
# - validation that uuids are present
# - generation of uuids
# - Conversion of uuids to a more readable format
#
# @author Joe Blog <Joe.Blog@nowhere.com>
#
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
