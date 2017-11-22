# frozen_string_literal: true

# Add standard sets table
class CreateStandardSets < ActiveRecord::Migration
  def change
    create_table :standard_sets do |t|
      t.uuid :uuid, uniq: true, null: false
      t.timestamps null: false
    end
  end
end
