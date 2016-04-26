class CreateQuants < ActiveRecord::Migration
  def change
    create_table :quants do |t|
      t.references :quant_type, null: false, foreign_key: true
      t.references :assay, null: false, foreign_key: true
      t.references :input, null: false, foreign_key: true
      t.references :standard, foreign_key: true

      t.timestamps null: false
    end
  end
end
