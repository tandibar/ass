class Article < ActiveRecord::Base
  belongs_to :image
  belongs_to :author
  has_many :comments do
    def build(attributes = {}, author = nil)
      if author
        author.comments.build(attributes.merge(:article => proxy_owner))
      else
        AnonymousComment.new(attributes.merge(:article => proxy_owner))
      end
    end
  end
  
  validates_presence_of :author
  validates_presence_of :author_id
  validates_presence_of :content
  validates_presence_of :title
end
