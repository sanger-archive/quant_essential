# frozen_string_literal: true

class RemoveCacheOfSwipecardCode < ActiveRecord::Migration
  def change
    remove_column :users, :encrypted_swipecard_code, :string, null: false
  end
end
