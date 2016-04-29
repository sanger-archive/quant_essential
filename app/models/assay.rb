
class Assay < ActiveRecord::Base
  include Barcode::Barcodable
  include Barcode::BarcodableAutoGen

  self.per_page = 25
  self.barcode_prefix = 'A'

  # An assay set primarily exists to group assays together for the purpose
  # of RESTful bulk creation.
  belongs_to :assay_set

  scope :latest_first, ->() { order(id: :desc) }

end
