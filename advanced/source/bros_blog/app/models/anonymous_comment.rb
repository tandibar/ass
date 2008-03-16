class AnonymousComment < Comment
  validates_presence_of :author_email
  
  def author
    author_email
  end
end