# frozen_string_literal: true

# Add standards table
class CreateStandards < ActiveRecord::Migration
  def change
    create_table :standards do |t|
      t.references :standard_type, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
