# frozen_string_literal: true

# Create the printers table so we can track the label type
class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :name, null: false, index: true
      t.string :description, null: true
      t.references :label_template, foreign_key: true, null: false
    end
  end
end
