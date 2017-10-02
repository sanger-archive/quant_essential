require './lib/sanger128'
class Barcode < ActiveRecord::Base
  # Must point to an object that responds to generate and takes an array of barcode elements.
  # This is configured in our initializer to generate barcodes matching the agreed Sanger
  # Code128 style
  class_attribute :barcode_generator

  # Ideally we'd do this with an initializer, but rails class reloading makes dependency injection tricky
  self.barcode_generator = Sanger128.new(Rails.configuration.application_barcode_prefix)

  belongs_to :barcodable, polymorphic: true, inverse_of: :barcode_object

  def generate=(*components)
    raise StandardError, 'Barcode.barcode_generator is not set!' if barcode_generator.nil?
    self.barcode = barcode_generator.generate(*components)
  end

  def self.find_barcodable_with_barcode(barcode)
    converted_barcode = if SBCF::HUMAN_BARCODE_FORMAT === barcode
                          SBCF::SangerBarcode.from_human(barcode).machine_barcode
                        else
                          barcode
                        end
    Barcode.find_by(barcode: converted_barcode).try(:barcodable)
  end
end
