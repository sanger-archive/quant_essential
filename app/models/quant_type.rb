class QuantType < ActiveRecord::Base
  include NamedBehaviour

  belongs_to :standard_type, inverse_of: :quant_types
  validates :standard_type, presence: true
end
