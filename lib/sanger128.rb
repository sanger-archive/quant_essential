# Generates barcodes according to the agreed internal Code128 standard
# - 4 character application specific prefix
# - Prefixes of 3 characters are right padded with the separator: "_" by default
# - We prevent prefixes of <3 characters
# - Valid characters are ({0-9}{A-Z}-_)
# - Maximum length is 25 characters (including prefix) as longer barcodes have issues printing
class Sanger128
  # Default minimum length for a barcode prefix
  MIN_PREFIX_LENGTH = 3
  # Default maximum length for a barcode prefix
  MAX_PREFIX_LENGTH = 4
  # Default maximum lenght for an overall barcode
  MAX_BARCODE_LENGTH = 25
  # Default Regex defining the acceptable characters
  VALID_EXPRESSION = /\A[A-Z0-9_-]+\z/
  # Default symbol used to separate barcode components
  DEFUALT_SEPARATOR = "_"

  # Raised in the event someone attempts to generate an invalid barcode
  InvalidBarcode = Class.new(StandardError)

  attr_reader :base_prefix, :separator, :min_prefix, :max_prefix, :max_barcode, :valid_expression

  # Creates a barcode generator with base_prefix
  # Optional:
  # separator - The character that gets inserted between barcode components (Default = '_')
  # min_prefix_length - Overide the default minimum prefix length ( Default = 3 )
  # max_prefix_length - Overide the default minimum prefix length ( Default = 4 )
  # max_barcode_length - Overide the default maximum barcode length ( Default = 25 )
  # valid_expression - Overide the default regex used for validation ( Default = /\A[A-Z0-9_-]+\z/ )
  def initialize(
    base_prefix,
    separator          = DEFUALT_SEPARATOR,
    min_prefix_length  = MIN_PREFIX_LENGTH,
    max_prefix_length  = MAX_PREFIX_LENGTH,
    max_barcode_length = MAX_BARCODE_LENGTH,
    valid_expression   = VALID_EXPRESSION
  )
    # Set up validation parameters
    @min_prefix = min_prefix_length
    @max_prefix = max_prefix_length
    @max_barcode = max_barcode_length
    @valid_expression = valid_expression

    raise_on_invalid_prefix!(base_prefix)
    @base_prefix = base_prefix.ljust(MAX_PREFIX_LENGTH, separator).freeze
    @separator = separator
  end

  # Take one or more arguments, returns a valid barcode string, or raises InvalidBarcode if the parameters are unsuitable
  def generate(*components)
    barcode = [base_prefix, *components].join(separator)
    raise_on_invalid_barcode!(barcode)
    barcode
  end

  def min_barcode
    min_prefix + separator.length + 1
  end

  private

  def raise_on_invalid_prefix!(test_prefix)
    raise_on_invalid_content!(test_prefix, min_prefix, max_prefix, valid_expression)
  end

  def raise_on_invalid_barcode!(test_barcode)
    raise_on_invalid_content!(test_barcode, min_barcode, max_barcode, valid_expression)
  end

  def raise_on_invalid_content!(test, min, max, regex)
    raise InvalidBarcode, "'#{test}' is shorter than #{min} characters" if test.length < min
    raise InvalidBarcode, "'#{test}' is longer than #{max} characters" if test.length > max
    raise InvalidBarcode, "'#{test}' contains invalid characters" unless regex === test
  end
end
