class AuthorComment < Comment
  belongs_to :author
  
  validates_presence_of :author
  validates_presence_of :author_id
  
  def author_email
    author.email
  end
end