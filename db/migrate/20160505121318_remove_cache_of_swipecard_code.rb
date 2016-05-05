class RemoveCacheOfSwipecardCode < ActiveRecord::Migration
  def change
    remove_column :users, :encrypted_swipecard_code, :sting, null: false
  end
end
