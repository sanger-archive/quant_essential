class AssaySet < ActiveRecord::Base
  # include ActiveUUID::UUID
  include HasUuid

  attr_accessor :assay_count

  has_many :assays, inverse_of: :assay_set

  validates :assay_count, on: :create, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :latest_first, ->() { order(id: :desc) }

  before_create :generate_assay_sets

  private

  def generate_assay_sets
    assays.build([{}]*assay_count.to_i)
  end

end
