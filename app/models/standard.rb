class Standard < ActiveRecord::Base
  include Barcodable
  include BarcodeAutogen
  include OrderScopes

  self.barcode_prefix = 'S'

  belongs_to :standard_type, required: true, validate: true, inverse_of: :standards
  has_one :quant, inverse_of: :standard

  scope :include_for_list, ->() { include_barcode.includes({quant:[{assay: :barcode_object},{quant_type: :standard_type}]},:standard_type) }

  # A standard set primarily exists to group standards together for the purpose
  # of RESTful bulk creation.
  belongs_to :standard_set, inverse_of: :standards

  def has_quant?
    quant.present?
  end

end
