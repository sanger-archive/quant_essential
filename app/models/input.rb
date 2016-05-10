require './lib/sequencescape_search'

class Input < ActiveRecord::Base
  include Barcodable
  include OrderScopes

  has_many :quants, inverse_of: :assay

  # Must point to an object that responds to find with a barcode and returns a has appropriate for input creation
  class_attribute :external_service

  # Ideally we'd do this with an initializer, but rails class reloading makes dependency injection tricky
  self.external_service = SequencescapeSearch.new(Rails.configuration.api_root,SequencescapeSearch.plate_barcode_search)


  # We don't use the Has UUID concern as the uuid is supplied externally.
  # We don't want to autogenerate it, nor do we care about friendly presentation
  validates :uuid, presence: true
  validates :barcode_object, presence: true

  def barcode=(new_barcode)
    barcode_target = barcode_object||build_barcode_object
    barcode_target.barcode=new_barcode
  end

  # Find an input with barcode 'barcode' or import from the defined service
  # If not specifies uses Input#external_service
  def self.find_with_barcode(barcode,service=self.external_service)
    super||import_from_service(barcode,service)
  end

  private

  def self.import_from_service(barcode,service)
    external_params = service.find(barcode)
    return nil if external_params.nil?
    create!(external_params.merge(:barcode=>barcode))
  end
end
