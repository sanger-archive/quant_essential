# Include in classes which can be barcoded
module Barcodable
  def self.included(base)
    base.class_eval do
      has_one :barcode_object, class_name: 'Barcode', as: :barcodable
      delegate :barcode, to: :barcode_object
      scope :include_barcode, ->() { includes(:barcode_object) }
    end
  end
end
