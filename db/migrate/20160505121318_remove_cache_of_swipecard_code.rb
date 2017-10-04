# frozen_string_literal: true

# Drop the swipecard code and avoid caching it.
class RemoveCacheOfSwipecardCode < ActiveRecord::Migration
  def change
    remove_column :users, :encrypted_swipecard_code, :string, null: false
  end
end
