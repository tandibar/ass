class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :salt
      t.string :salted_password
      t.string :token
      t.datetime :token_expiry

      t.timestamps
    end
  end

  def self.down
    drop_table :authors
  end
end
