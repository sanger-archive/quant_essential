class StandardType < ActiveRecord::Base
  include NamedBehaviour

  has_many :quant_types, inverse_of: :standard_type
  has_many :standards, inverse_of: :standard_type
end
