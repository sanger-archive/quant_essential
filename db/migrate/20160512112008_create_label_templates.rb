# frozen_string_literal: true

# Create the label templates table to store template names and foreign ids.
class CreateLabelTemplates < ActiveRecord::Migration
  def change
    create_table :label_templates do |t|
      t.string :name, null: false, unique: true
      t.integer :external_id, null: false, unique: true

      t.timestamps null: false
    end
  end
end
