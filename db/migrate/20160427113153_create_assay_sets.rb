# frozen_string_literal: true

class CreateAssaySets < ActiveRecord::Migration
  def change
    create_table :assay_sets do |t|
      t.uuid :uuid, uniq: true, null: false
      t.timestamps null: false
    end
  end
end
