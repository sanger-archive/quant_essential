class CreateQuantTypes < ActiveRecord::Migration
  def change
    create_table :process_types do |t|
      t.string, :name, null: false, uniqueness: true
      t.references :standard_type, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
