# frozen_string_literal: true

class AddStandardTypeIdColumnToStandardSets < ActiveRecord::Migration
  def change
    change_table :standard_sets do |t|
      t.references :standard_type, null: false, foreign_key: true, after: :uuid
    end
  end
end
