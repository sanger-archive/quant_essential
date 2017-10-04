# frozen_string_literal: true

# Assays belong to assay sets. It is a foreign key.
class AddAssaySetIdToAssays < ActiveRecord::Migration
  def change
    change_table :assays do |t|
      t.references :assay_set, null: false, foreign_key: true, after: :id
    end
  end
end
