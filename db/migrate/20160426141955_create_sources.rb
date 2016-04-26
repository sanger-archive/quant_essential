class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string, :name, null: false
      t.string, :key, null: false, uniqueness: true

      t.timestamps null: false
    end
  end
end
