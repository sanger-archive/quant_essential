class CreateStandardTypes < ActiveRecord::Migration
  def change
    create_table :standard_types do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
