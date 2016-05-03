class StandardSet < ActiveRecord::Base
  include ActiveUUID::UUID
  include HasUuid
  include OrderScopes

  attr_accessor :standard_count, :standard_type_id

  has_many :standards, inverse_of: :standard_set

  validates :standard_count, on: :create, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :standard_type_id, presence: true

  before_create :generate_standard_sets

  private

  def generate_standard_sets
    standards.build([default_standard_attributes]*standard_count.to_i)
  end

  def default_standard_attributes
    {
      standard_type_id: standard_type_id
    }
  end

end
