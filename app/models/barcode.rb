require './lib/sanger128'
class Barcode < ActiveRecord::Base

  # Must point to an object that responds to generate and takes an array of barcode elements.
  # This is configured in our initializer to generate barcodes matching the agreed Sanger
  # Code128 style
  class_attribute :barcode_generator

  # Ideally we'd do this with an initializer, but rails class reloading makes dependency injection tricky
  self.barcode_generator = Sanger128.new(Rails.configuration.application_barcode_prefix)

  # Include in classes which can be barcoded
  module Barcodable
    def self.included(base)
      base.class_eval do
        has_one :barcode_object, class_name: 'Barcode', as: :barcodable
        delegate :barcode, to: :barcode_object
      end
    end
  end

  # Include in classes which generate their own barcodes after create
  module BarcodableAutoGen

    def self.included(base)
      base.class_eval do

        class_attribute :barcode_prefix
        after_create :generate_barcode

        scope :with_barcode, ->(barcode) { joins(:barcode_object).where(barcodes:{barcode:barcode}) }
      end
    end

    def generate_barcode
      create_barcode_object!(generate:[barcode_prefix,id])
    end
  end

  belongs_to :barcodable, polymorphic: true

  def generate=(*components)
    raise StandardError, "Barcode.barcode_generator is not set!" if barcode_generator.nil?
    self.barcode = barcode_generator.generate(*components)
  end
end
