# frozen_string_literal: true

#
# Class AssaySet provides a means of creating #assay_count Assays
# @attr [Int] assay_countThe number of assays to be created. This is not persisted
class AssaySet < ActiveRecord::Base
  include ActiveUUID::UUID
  include HasUuid
  include OrderScopes

  attr_accessor :assay_count

  def to_param
    friendly_uuid
  end

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
