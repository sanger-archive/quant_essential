# frozen_string_literal: true

# Include in classes which can be barcoded
module Barcodable
  extend ActiveSupport::Concern

  class_methods do
    def find_with_barcode(barcode, _service = nil)
      with_barcode(barcode).first
    end
  end

  included do
    has_one :barcode_object, class_name: 'Barcode', as: :barcodable, dependent: :destroy

    delegate :barcode, to: :barcode_object

    scope :include_barcode, ->() { includes(:barcode_object) }
    scope :with_barcode, ->(barcode) { joins(:barcode_object).where(barcodes: { barcode: barcode }) }
  end

  def printables
    [self]
  end

  def label_atttibutes
    { label: { top_line: label_description, bottom_line: barcode, barcode: barcode } }
  end

  def label_description
    self.class.name
  end
end
