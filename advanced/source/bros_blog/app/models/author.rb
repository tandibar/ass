class Author < ActiveRecord::Base
  
  acts_as_authenticatable
  
  has_many :articles
  has_many :comments, :class_name => "AuthorComment", :foreign_key => "author_id"
  
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :email
end
