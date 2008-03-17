require File.dirname(__FILE__) + '/../test_helper'

class AuthorTest < ActiveSupport::TestCase
  
  fixtures :authors
  
  def test_should_have_a_firstname
    author = Author.new
    assert !author.valid?, "Author should be invalid."
    assert author.errors.invalid?(:firstname), "Firstname is not invalid."
  end
  
  def test_should_have_a_lastname
    author = Author.new
    assert !author.valid?, "Author should be invalid."
    assert author.errors.invalid?(:lastname), "Lastname is not invalid."
  end
  
  def test_should_have_a_email
    author = Author.new
    assert !author.valid?, "Author should be invalid."
    assert author.errors.invalid?(:email), "E-Mail is not invalid."
  end
  
  def test_should_have_articles
    author = authors(:author_with_articles)
    assert_not_nil author.articles, "Aricles should not be nil."
    assert_kind_of Array, author.articles, "Articles of Author should be an Array."
  end
  
  def test_should_have_comments
    author = authors(:author_with_comments)
    assert_not_nil author.comments, "Comments should not be nil."
    assert_kind_of Array, author.comments, "Comments of Author should be an Array."
  end
  
  def test_should_confirm_email_on_create
    author = Author.new
    author.email = "thesameemail@test.com"
    author.email_confirmation = "not_thesameemail@test.com"
    assert !author.save, "Author should be not save."
    assert author.errors.invalid?(:email), "Confirmation of Email should be invalid."
  end
  
  def test_should_require_confirmation_of_email
    author = Author.new
    author.email = "thesameemail@test.com"
    author.email_confirmation = nil
    assert !author.save, "Author should be not save."
    assert author.errors.invalid?(:email_confirmation), "Confirmation of Email should be invalid."
  end
  
end
