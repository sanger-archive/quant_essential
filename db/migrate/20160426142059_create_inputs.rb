class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.string, :uuid, null: false, uniqueness: true
      t.string, :external_type, null: false
      t.references, :source, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
