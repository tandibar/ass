class RemoveImageIdFromArticles < ActiveRecord::Migration
  def self.up
    remove_column :articles, :image_id
  end

  def self.down
    add_column :articles, :image_id, :integer
  end
end
