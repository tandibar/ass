class CreateTableForTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
    end
    
    create_table :articles_tags, :id => false do |t|
      t.column :article_id, :integer
      t.column :tag_id, :integer
    end
    
    add_index :articles_tags, ["article_id", "tag_id"], :unique => true
    
    # execute "ALTER TABLE `articles_tags` ADD CONSTRAINT PRIMARY KEY `pk_articles_tags` (`article_id`, `tag_id`)"
  end

  def self.down
    drop_table :tags
    drop_table :articles_tags
  end
end
