class AddAdminUser < ActiveRecord::Migration
  def self.up
    add_column :users, :salt, :string
    
    User.create(:email => "andi.bade@gmail.com",
                :firstname => "Andi",
                :lastname => "Bade",
                :password => "mypassword",
                :confirm_password => "mypassword")
  end

  def self.down
    User.find_by_email("andi.bade@gmail.com").destroy
    remove_column :users, :salt
  end
end
