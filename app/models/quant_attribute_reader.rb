# Receives the quant creation form information and looks up the resources.
# Avoids us needing to contaminate Quant itself with too much understanding of barcodes
class QuantAttributeReader
  include ActiveModel::Model

  def self.model_name
    ActiveModel::Name.new(Quant)
  end

  attr_accessor :swipecard_code, :quant_type, :assay_barcode, :standard_barcode, :input_barcode

  validates_presence_of :swipecard_code, :quant_type, :assay_barcode, :standard_barcode, :input_barcode

  # We define messages manually here as the standard rails approach doesn't seem to work for non-active-record objects

  validates_presence_of :input, if: :input_barcode, message: I18n.t(:not_found, scope: %i[errors quant_attribute_reader input_barcode])

  validate :assay_is_suitable?, if: :assay_barcode
  validate :standard_is_suitable?, if: :standard_barcode
  validate :user_is_suitable?, if: :swipecard_code
  validate :input_is_suitable?, if: :input_barcode

  def validate_and_create_quant
    return false unless valid?
    quant.save || errors.add(:quant, quant.errors.full_messages)
  end

  def quant
    @quant ||= Quant.new(quant_params)
  end

  private

  # An assay barcode must may to an assay plate, and the assay plate must be unused
  def assay_is_suitable?
    errors.add(:assay_barcode, I18n.t(:not_found, scope: %i[errors quant_attribute_reader assay_barcode])) if assay.nil?
    errors.add(:assay_barcode, I18n.t(:used, scope: %i[errors quant_attribute_reader assay_barcode])) if assay.present? && assay.has_quant?
  end

  # A standard barcode must map to a standard plate, the plate must be unused, and must be of the right standard type
  def standard_is_suitable?
    errors.add(:standard_barcode, I18n.t(:not_found, scope: %i[errors quant_attribute_reader standard_barcode])) if standard.nil?
    errors.add(:standard_barcode, I18n.t(:unsuitable, scope: %i[errors quant_attribute_reader standard_barcode])) if wrong_standard_type?
  end

  def user_is_suitable?
    errors.add(:swipecard_code, I18n.t(:not_found, scope: %i[errors quant_attribute_reader swipecard_code])) if user.nil?
  end

  def input_is_suitable?
    errors.add(:input_barcode, I18n.t(:not_found, scope: %i[errors quant_attribute_reader input_barcode])) if input.nil?
  end

  def wrong_standard_type?
    return false unless quant_type_resource.present? && standard.present?
    standard.standard_type != quant_type_resource.standard_type
  end

  def quant_params
    {
      quant_type: quant_type_resource,
      assay: assay,
      standard: standard,
      input: input,
      user: user
    }
  end

  def user
    @user ||= User.find_with_swipecard(swipecard_code)
  end

  def assay
    @assay ||= Assay.find_with_barcode(assay_barcode)
  end

  def standard
    @standard ||= Standard.find_with_barcode(standard_barcode)
  end

  def input
    @input ||= Input.find_with_barcode(input_barcode)
  end

  def quant_type_resource
    @qant_type_resource ||= QuantType.find(quant_type)
  end
end
