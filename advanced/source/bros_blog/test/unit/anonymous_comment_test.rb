require File.dirname(__FILE__) + '/../test_helper'

class AnonymousCommentTest < ActiveSupport::TestCase

  def test_should_have_an_author_email
    comment = AnonymousComment.new
    assert !comment.valid?, "AnonymousComment should be invalid."
    assert comment.errors.invalid?(:author_email), "Author Email is not invalid."
  end
  
end