# Receives the quant creation form information and looks up the resources.
# Avoids us needing to contaminate Quant itself with too much understanding of barcodes
class QuantAttributeReader
  include ActiveModel::Model

  attr_accessor :swipecard_code, :quant_type, :assay_barcode, :standard_barcode, :input_barcode

  validates_presence_of :swipecard_code, :quant_type, :assay_barcode, :standard_barcode, :input_barcode

  # We define messages manually here as the standard rails approach doesn't seem to work for non-active-record objects
  validates_presence_of :user, :if => :swipecard_code, :message => I18n.t(:user_not_found,scope:[:errors,:quant_attribute_reader])
  validates_presence_of :assay, :if => :assay_barcode, :message => I18n.t(:barcode_not_found,scope:[:errors,:quant_attribute_reader])
  validates_presence_of :standard, :if => :standard_barcode, :message => I18n.t(:barcode_not_found,scope:[:errors,:quant_attribute_reader])
  validates_presence_of :input, :if => :input_barcode, :message => I18n.t(:input_not_found,scope:[:errors,:quant_attribute_reader])

  def validate_and_create_quant
    valid? && quant.save
  end

  def quant
    @quant ||= Quant.new(quant_params)
  end

  private

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
    User.find_with_swipecard(swipecard_code)
  end

  def assay
    Assay.find_with_barcode(assay_barcode)
  end

  def standard
    Standard.find_with_barcode(standard_barcode)
  end

  def input
    Input.find_with_barcode(input_barcode)
  end

  def quant_type_resource
    QuantType.find(quant_type)
  end
end
