# frozen_string_literal: true

# Add barcodes table
class CreateBarcodes < ActiveRecord::Migration
  def change
    create_table :barcodes do |t|
      t.integer :barcodable_id, null: false
      t.string :barcodable_type, null: false
      t.string :barcode, null: false, index: true, uniqueness: true

      t.timestamps null: false
    end
  end
end
