require File.dirname(__FILE__) + '/../test_helper'

class AnonymousCommentTest < ActiveSupport::TestCase

  def test_should_have_an_author_email
    comment = AnonymousComment.new
    assert !comment.valid?, "AnonymousComment should be invalid."
    assert comment.errors.invalid?(:author_email), "Author Email is not invalid."
  end
  
  def test_should_delegate_the_call_to_author_to_the_auther_email
    comment = AnonymousComment.new(:author_email => "ben.grimm@ff.com")
    assert_equal comment.author, "ben.grimm@ff.com"
  end
  
end