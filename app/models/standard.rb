class Standard < ActiveRecord::Base
  include Barcodable
  include BarcodeAutogen
  include OrderScopes

  self.barcode_prefix = 'S'

  belongs_to :standard_type

  # A standard set primarily exists to group standards together for the purpose
  # of RESTful bulk creation.
  belongs_to :standard_set

  validates_presence_of :standard_type

end
