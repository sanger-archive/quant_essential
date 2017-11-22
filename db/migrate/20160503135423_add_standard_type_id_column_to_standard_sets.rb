# frozen_string_literal: true

# Standard sets belong to a standard type. It is a foreign key.
class AddStandardTypeIdColumnToStandardSets < ActiveRecord::Migration
  def change
    change_table :standard_sets do |t|
      t.references :standard_type, null: false, foreign_key: true, after: :uuid
    end
  end
end
