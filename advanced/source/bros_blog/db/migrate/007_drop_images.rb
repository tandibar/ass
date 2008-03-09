class DropImages < ActiveRecord::Migration
  def self.up
    drop_table :images
  end

  def self.down
    create_table "images", :force => true do |t|
      t.string   "name"
      t.string   "url"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
