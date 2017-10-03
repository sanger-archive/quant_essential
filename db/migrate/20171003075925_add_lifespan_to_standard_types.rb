# frozen_string_literal: true

class AddLifespanToStandardTypes < ActiveRecord::Migration
  def change
    add_column :standard_types, :lifespan, :integer
  end
end
