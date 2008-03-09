class RemoveTokenFromAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :security_token, :string
    add_column :authors, :new_email, :string
    add_column :authors, :verified, :boolean
    remove_column :authors, :token
  end

  def self.down
    remove_column :authors, :column_name
    remove_column :authors, :new_email
    add_column :authors, :token, :string
    remove_column :authors, :security_token
  end
end
