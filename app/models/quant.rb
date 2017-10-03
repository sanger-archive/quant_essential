class Quant < ActiveRecord::Base
  include OrderScopes

  def to_param; assay_barcode; end

  belongs_to :quant_type, inverse_of: :quants, required: true, validate: true
  belongs_to :assay, inverse_of: :quant, required: true, validate: true
  belongs_to :standard, inverse_of: :quants, required: true, validate: true
  belongs_to :input, inverse_of: :quants, required: true, validate: true
  belongs_to :user, inverse_of: :quants, required: true, validate: true

  scope :with_assay_barcode, ->(barcode) { joins(assay: :barcode_object).where(barcodes: { barcode: barcode }) }

  # Caution! Expired merely indicates that the standard is expired NOW, not necessarily when it was used.
  delegate :expired?, :barcode, to: :standard, prefix: true, allow_nil: true
  delegate :barcode, to: :assay, prefix: true, allow_nil: true
  delegate :barcode, to: :input, prefix: true, allow_nil: true
  delegate :name, to: :quant_type, prefix: true

  def name
    "#{assay_barcode}:#{quant_type_name}"
  end

  def standard_age_at_creation
    standard.age_at(created_at)
  end

  def standard_expired_at_creation?
    standard.expired_at?(created_at)
  end
end
