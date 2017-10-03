# frozen_string_literal: true

class StandardType < ActiveRecord::Base
  include NamedBehaviour

  has_many :quant_types, inverse_of: :standard_type
  has_many :standards, inverse_of: :standard_type

  validates :lifespan, numericality: { greater_than: 0, only_integer: true, allow_nil: true }
end
