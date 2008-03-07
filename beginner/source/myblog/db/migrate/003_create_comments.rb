class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :author, :string
      t.column :email, :string
      t.column :content, :string
      t.column :article_id, :integer
    end
  end

  def self.down
    drop_table :comments
  end
end
