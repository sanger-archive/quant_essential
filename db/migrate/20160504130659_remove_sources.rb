class RemoveSources < ActiveRecord::Migration
  def change
    remove_foreign_key :inputs, column: :source_id
    change_table :inputs do |t|
      t.remove :source_id
    end
    drop_table :sources do |t|
      t.string :name, null: false
      t.string :key, null: false, uniqueness: true

      t.timestamps null: false
    end
  end
end
