require 'test_helper'

class QuantAttributeReaderTest < ActiveSupport::TestCase
  class MockLookup
    def initialize(user)
      @user = user
    end

    def find(_swipe)
      @user
    end
  end

  attr_reader :assay, :standard, :quant_type, :input, :standard_type

  setup do
    @cache_lookup = User.external_service
    @cache_input_lookup = Input.external_service
    User.external_service = MockLookup.new(login: 'mock', uuid: '000')
    @assay = create :assay
    @standard_type = create :standard_type, lifespan: 1
    @standard = create :standard, standard_type: standard_type
    @quant_type = create :quant_type, standard_type: standard_type
    @input = create :input
  end

  def defaults(with = {})
    {
      swipecard_code: 'swipe',
      quant_type: quant_type.id,
      assay_barcode: assay.barcode,
      standard_barcode: standard.barcode,
      input_barcode: input.barcode
    }.merge(with)
  end

  test 'creates a quant when everything is fine' do
    qar = QuantAttributeReader.new(defaults)
    assert_difference('Quant.count', 1) do
      assert qar.validate_and_create_quant
    end
  end

  test 'errors when an assay doesn\'t exist' do
    qar = QuantAttributeReader.new(defaults(assay_barcode: 'not an assay'))
    assert_difference('Quant.count', 0) do
      refute qar.validate_and_create_quant
    end
    assert_includes qar.errors.full_messages,
                    "Assay barcode does not match an assay resource. Make sure you haven't scanned a barcode into the wrong box"
  end

  test 'errors when an assay has been used' do
    create :quant, assay: @assay
    qar = QuantAttributeReader.new(defaults)
    assert_difference('Quant.count', 0) do
      refute qar.validate_and_create_quant
    end
    assert_includes qar.errors.full_messages,
                    'Assay barcode has already been used'
  end

  test 'errors when a standard doesn\'t exist' do
    qar = QuantAttributeReader.new(defaults(standard_barcode: 'nothing'))
    assert_difference('Quant.count', 0) do
      refute qar.validate_and_create_quant
    end
    assert_includes qar.errors.full_messages,
                    "Standard barcode does not match a standard resource. Make sure you haven't scanned a barcode into the wrong box"
  end

  test 'errors when a standard is the wrong type' do
    qar = QuantAttributeReader.new(defaults(standard_barcode: create(:standard).barcode))
    assert_difference('Quant.count', 0) do
      refute qar.validate_and_create_quant
    end
    assert_includes qar.errors.full_messages, 'Standard barcode is an unsuitable type for this quant process'
  end

  test 'errors when a standard is the expired' do
    expired_standard = create(:standard, created_at: DateTime.yesterday, standard_type: standard_type)
    qar = QuantAttributeReader.new(defaults(standard_barcode: expired_standard.barcode))
    assert_difference('Quant.count', 0) do
      refute qar.validate_and_create_quant
    end
    assert_includes qar.errors.full_messages, 'Standard barcode has expired. Please use a different standard'
  end

  test 'creates a quant when a standard is expired but overidden' do
    expired_standard = create(:standard, created_at: DateTime.yesterday, standard_type: standard_type)
    qar = QuantAttributeReader.new(defaults(standard_barcode: expired_standard.barcode, override_expiry_date: '1'))
    assert_difference('Quant.count', 1) do
      assert qar.validate_and_create_quant
    end
  end

  test 'errors when a user can\'t be found' do
    User.external_service = MockLookup.new(nil)

    qar = QuantAttributeReader.new(defaults)
    assert_difference('Quant.count', 0) do
      refute qar.validate_and_create_quant
    end
    assert_includes(qar.errors.full_messages.first, 'Swipecard code could not be found.')
  end

  test 'errors when an input can\'t be found' do
    qar = QuantAttributeReader.new(defaults(input_barcode: 'none'))
    Input.external_service = MockLookup.new(nil)
    assert_difference('Quant.count', 0) do
      refute qar.validate_and_create_quant
    end
    assert_includes qar.errors.full_messages,
                    'Input barcode does not match a known resource. Inputs must be Sequencescape plates'
  end

  teardown do
    User.external_service = @cache_lookup
    Input.external_service = @cache_input_lookup
  end
end
