class Author < ActiveRecord::Base
  
  has_many :articles
  
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :email
end
