# Include in classes which can be barcoded
module Barcodable

  module ClassMethods
    def find_with_barcode(barcode,service=nil)
      with_barcode(barcode).first
    end
  end

  def self.included(base)
    base.class_eval do

      extend Barcodable::ClassMethods

      has_one :barcode_object, class_name: 'Barcode', as: :barcodable, dependent: :destroy

      delegate :barcode, to: :barcode_object

      scope :include_barcode, ->() { includes(:barcode_object) }
      scope :with_barcode, ->(barcode) { joins(:barcode_object).where(barcodes:{barcode:barcode}) }

      def printables
        [self]
      end

      def label_atttibutes

      end
    end
  end

end
