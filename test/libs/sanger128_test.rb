require 'test_helper'
require './lib/sanger128'

class Sanger128Test < ActiveSupport::TestCase
  test 'rejects too short prefixes' do
    assert_raises Sanger128::InvalidBarcode do
      Sanger128.new('PF')
    end
  end

  test 'rejects too long prefixes' do
    assert_raises Sanger128::InvalidBarcode do
      Sanger128.new('LONGPREFIX')
    end
  end

  test 'rejects prefixes with invalid characters' do
    assert_raises Sanger128::InvalidBarcode do
      Sanger128.new('low*')
    end
  end

  test 'pads three character prefixes' do
    generator = Sanger128.new('LOW')
    assert_equal 'LOW_', generator.base_prefix
  end

  test 'can generate a barcode from a single value' do
    generator = Sanger128.new('PREF')
    barcode = generator.generate(12_345)
    assert_equal 'PREF_12345', barcode
  end

  test 'can generate a barcode from multiple values' do
    generator = Sanger128.new('PREF')
    barcode = generator.generate('A', 12_345)
    assert_equal 'PREF_A_12345', barcode
  end

  test 'rejects values with invalid characters' do
    generator = Sanger128.new('PREF')
    assert_raises Sanger128::InvalidBarcode do
      barcode = generator.generate('f', 12_345)
    end
  end

  test 'rejects barcodes which are too long' do
    generator = Sanger128.new('PREF')
    assert_raises Sanger128::InvalidBarcode do
      barcode = generator.generate('ABCDEFG', 'F' * 20, 12_345)
    end
  end
end
