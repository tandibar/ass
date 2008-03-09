class UploadImageToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :image_url, :string
    add_column :articles, :image_name, :string
  end

  def self.down
    remove_column :articles, :image_url
    remove_column :articles, :image_name
  end
end
