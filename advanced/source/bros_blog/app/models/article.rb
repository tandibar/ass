class Article < ActiveRecord::Base
  class CommentDeletionNotAllowed < RuntimeError; end
  
  belongs_to :image
  belongs_to :author
  has_many :comments, :dependent => :destroy do
    def build(attributes = {}, author = nil)
      if author
        author.comments.build(attributes.merge(:article => proxy_owner))
      else
        AnonymousComment.new(attributes.merge(:article => proxy_owner))
      end
    end
    
    def delete(comments, author)
      comments = [comments] unless comments.respond_to?(:all?)
      if comments.all? { |comment| comment.article.author == author }
        super(comments)
      else
        raise Article::CommentDeletionNotAllowed, "Deletion of Comments only allowed by Author of Article."
      end
    end
  end
  
  validates_presence_of :author
  validates_presence_of :author_id
  validates_presence_of :content
  validates_presence_of :title
end
