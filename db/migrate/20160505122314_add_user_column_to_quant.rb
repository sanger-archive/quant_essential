# frozen_string_literal: true

# Add user_id to quant to track who performed it
class AddUserColumnToQuant < ActiveRecord::Migration
  def change
    change_table :quants do |t|
      t.references :user, null: false
    end
  end
end
