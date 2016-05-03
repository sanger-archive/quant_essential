
class Assay < ActiveRecord::Base
  include Barcodable
  include BarcodeAutogen
  include OrderScopes

  self.barcode_prefix = 'A'

  # An assay set primarily exists to group assays together for the purpose
  # of RESTful bulk creation.
  belongs_to :assay_set

  def has_quant?
    false
  end

end
