class QuantType < ActiveRecord::Base
  include NamedBehaviour

  belongs_to :standard_type, inverse_of: :quant_types, required: true

  has_many :quants, inverse_of: :quant_type

end
