# frozen_string_literal: true

# Add names to inputs to replace the loss from sources.
class AddNameColumnToInput < ActiveRecord::Migration
  def change
    change_table :inputs do |t|
      t.string :name, null: false, after: :uuid
    end
  end
end
