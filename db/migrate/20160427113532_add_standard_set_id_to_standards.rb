# frozen_string_literal: true

# Standards belong to standard sets. It is a foreign key.
class AddStandardSetIdToStandards < ActiveRecord::Migration
  def change
    change_table :standards do |t|
      t.references :standard_set, null: false, foreign_key: true, after: :id
    end
  end
end
