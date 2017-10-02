# Include in classes which generate their own barcodes after create
module BarcodeAutogen
  def self.included(base)
    base.class_eval do
      class_attribute :barcode_prefix
      after_create :generate_barcode
    end
  end

  def generate_barcode
    create_barcode_object!(generate: [barcode_prefix, id])
  end
end
