class Quant < ActiveRecord::Base
  include OrderScopes

  def to_param; assay_barcode; end

  belongs_to :quant_type, inverse_of: :quants, required: true, validate: true
  belongs_to :assay, inverse_of: :quant, required: true, validate: true
  belongs_to :standard, inverse_of: :quants, required: true, validate: true
  belongs_to :input, inverse_of: :quants, required: true, validate: true
  belongs_to :user, inverse_of: :quants, required: true, validate: true

  scope :with_assay_barcode, ->(barcode) { joins(assay: :barcode_object).where(barcodes: { barcode: barcode }) }

  def name
    "#{assay_barcode}:#{quant_type.name}"
  end

  def assay_barcode
    assay.try(:barcode)
  end

  def standard_barcode
    standard.try(:barcode)
  end

  def input_barcode
    input.try(:barcode)
  end
end
