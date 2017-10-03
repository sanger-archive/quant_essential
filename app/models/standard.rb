class Standard < ActiveRecord::Base
  include Barcodable
  include BarcodeAutogen
  include OrderScopes

  def to_param; barcode; end

  self.barcode_prefix = 'S'

  belongs_to :standard_type, required: true, validate: true, inverse_of: :standards
  has_many :quants, inverse_of: :standard

  scope :include_for_list, ->() { include_barcode.includes({ quants: [{ assay: :barcode_object }, { quant_type: :standard_type }] }, :standard_type) }

  # A standard set primarily exists to group standards together for the purpose
  # of RESTful bulk creation.
  belongs_to :standard_set, inverse_of: :standards

  delegate :lifespan, to: :standard_type

  def has_quant?
    quants.present?
  end

  def label_description
    standard_type.name
  end

  def expired?
    expired_at?(DateTime.current)
  end

  def expired_at?(time)
    lifespan.present? && time >= expires_at
  end

  def age_at(time)
    (time.to_date - created_at.to_date).to_i + 1
  end

  private

  def expires_at
    created_at.beginning_of_day + lifespan.days
  end
end
