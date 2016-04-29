class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.uuid :uuid
      t.string :encrypted_swipecard_code, null: false

      t.timestamps null: false
    end
  end
end
