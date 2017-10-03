# frozen_string_literal: true

class AddUserColumnToQuant < ActiveRecord::Migration
  def change
    change_table :quants do |t|
      t.references :user, null: false
    end
  end
end
