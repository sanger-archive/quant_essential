# frozen_string_literal: true

# Standards have a lot number
class AddLotNumberToStandard < ActiveRecord::Migration
  def change
    change_table :standards do |t|
      t.string :lot_number, null: true
    end
  end
end
