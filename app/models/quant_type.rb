# frozen_string_literal: true

#
# Class QuantType provides a means of identifying the type of qunat process performed
# When a quant is created the standard used must match that associated with the quant type
#
class QuantType < ActiveRecord::Base
  include NamedBehaviour

  belongs_to :standard_type, inverse_of: :quant_types, required: true

  has_many :quants, inverse_of: :quant_type
end
