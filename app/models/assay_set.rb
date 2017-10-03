# frozen_string_literal: true

class AssaySet < ActiveRecord::Base
  include ActiveUUID::UUID
  include HasUuid
  include OrderScopes

  attr_accessor :assay_count

  def to_param; friendly_uuid; end

  has_many :assays, inverse_of: :assay_set

  validates :assay_count, on: :create, presence: true, numericality: { only_integer: true, greater_than: 0 }

  before_create :generate_assay_sets

  # Printables is an array of the items that get printed
  alias_attribute :printables, :assays

  private

  def generate_assay_sets
    assays.build([{}] * assay_count.to_i)
  end
end
