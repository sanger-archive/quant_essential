class AddAssaySetIdToAssays < ActiveRecord::Migration
  def change
    change_table :assays do |t|
      t.references :assay_set, null: false, foreign_key: true, after: :id
    end
  end
end
