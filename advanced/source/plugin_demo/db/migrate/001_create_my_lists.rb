class CreateMyLists < ActiveRecord::Migration
  def self.up
    create_table :my_lists do |t|
      t.string :name
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :my_lists
  end
end
