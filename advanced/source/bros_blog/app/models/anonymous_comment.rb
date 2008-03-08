class AnonymousComment < Comment
  validates_presence_of :author_email
end