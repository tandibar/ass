class Author < ActiveRecord::Base
  
  has_many :articles
  has_many :comments, :class_name => "AuthorComment", :foreign_key => "author_id"
  
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :email
  
  validates_confirmation_of :email, :on => :create, :message => "should match confirmation"
  
  def to_s
    email
  end
  
  def self.authenticate(username, password)
    find_by_email_and_password(username, password)
  end
end
