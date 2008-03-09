class AddCreatedAtToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :created_at, :datetime
  end

  def self.down
    remove_column :articles, :created_at
  end
end
