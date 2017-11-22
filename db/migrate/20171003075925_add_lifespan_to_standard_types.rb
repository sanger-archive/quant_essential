# frozen_string_literal: true

# Add lifespan to standard types
# Lifespan is an optional integer, indicating the time
# in days for which standards will be valid. A value
# of 1 indicates that standards expire at midnight on the
# day of creation.
class AddLifespanToStandardTypes < ActiveRecord::Migration
  def change
    add_column :standard_types, :lifespan, :integer
  end
end
