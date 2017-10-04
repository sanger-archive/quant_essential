
# frozen_string_literal: true

#
# Class Assay describes a piece of labware which recieves material and is subject to a QC process
# It is the Assay barcode that helps link the Quant results back to the correct input.
# @attr [AssaySet] assay_set Assays are created in bulk via AssaySets
# @attr [String] barcode The uniquely identifying code128 barcode
class Assay < ActiveRecord::Base
  include Barcodable
  include BarcodeAutogen
  include OrderScopes

  self.barcode_prefix = 'A'

  def to_param
    barcode
  end

  # An assay set primarily exists to group assays together for the purpose
  # of RESTful bulk creation.
  belongs_to :assay_set

  has_one :quant, inverse_of: :assay

  scope :include_for_list, ->() { include_barcode.includes(quant: { quant_type: :standard_type }) }

  def quant?
    quant.present?
  end
end
