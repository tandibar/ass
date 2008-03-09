class RemoveTitleFromCommentAndAddHomepageToComment < ActiveRecord::Migration
  def self.up
    remove_column :comments, :title
    add_column :comments, :homepage, :string
  end

  def self.down
    remove_column :comments, :homepage
    add_column :comments, :title, :string
  end
end
