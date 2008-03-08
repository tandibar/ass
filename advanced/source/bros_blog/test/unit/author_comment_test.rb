require File.dirname(__FILE__) + '/../test_helper'

class AuthorCommentTest < ActiveSupport::TestCase
  
  def test_should_have_an_author
    comment = AuthorComment.new
    assert !comment.valid?, "AuthorComment is not invalid."
    assert comment.errors.invalid?(:author), "There is an Author where there should be none."
    assert comment.errors.invalid?(:author_id), "The author_id is not invalid."
  end
  
  def test_should_return_authors_email
    comment = AuthorComment.new(:author => Author.new(:email => "hans@wurst.de"))
    assert_equal "hans@wurst.de", comment.author_email
  end
  
end