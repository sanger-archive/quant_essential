# frozen_string_literal: true

# Add assays table
class CreateAssays < ActiveRecord::Migration
  def change
    create_table :assays do |t|
      t.timestamps null: false
    end
  end
end
