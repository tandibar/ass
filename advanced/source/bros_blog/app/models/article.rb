class Article < ActiveRecord::Base
  belongs_to :image
  belongs_to :author
  has_many :comments
  
  validates_presence_of :author
  validates_presence_of :author_id
  validates_presence_of :content
  validates_presence_of :title
end
