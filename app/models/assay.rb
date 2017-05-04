
class Assay < ActiveRecord::Base
  include Barcodable
  include BarcodeAutogen
  include OrderScopes

  self.barcode_prefix = 'A'

  def to_param; barcode; end

  # An assay set primarily exists to group assays together for the purpose
  # of RESTful bulk creation.
  belongs_to :assay_set

  has_one :quant, inverse_of: :assay

  scope :include_for_list, ->() { include_barcode.includes(quant: { quant_type: :standard_type }) }

  def has_quant?
    quant.present?
  end
end
