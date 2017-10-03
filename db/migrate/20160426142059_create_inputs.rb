# frozen_string_literal: true

class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.uuid :uuid, null: false, uniqueness: true
      t.string :external_type, null: false
      t.references :source, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
