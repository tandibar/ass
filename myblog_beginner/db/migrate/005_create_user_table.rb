class CreateUserTable < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :email, :string
      t.column :firstname, :string
      t.column :lastname, :string
      t.column :password, :string
      t.column :created_at, :datetime
    end
  end

  def self.down
  end
end
