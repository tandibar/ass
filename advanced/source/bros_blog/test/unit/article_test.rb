require File.dirname(__FILE__) + '/../test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  fixtures :articles, :comments, :authors
  
  def test_should_have_comments
    article = articles(:article_with_comment)
    assert_not_nil article.comments, "Comments should not be nil."
    assert_kind_of Array, article.comments, "There should be an object of kind Array."
  end
  
  def test_should_have_a_title
    article = Article.new
    assert !article.valid?, "Article should be invalid."
    assert article.errors.invalid?(:title), "Title is not invalid."
  end
  
  def test_should_have_a_content
    article = Article.new
    assert !article.valid?, "Article should be invalid."
    assert article.errors.invalid?(:content), "Content is not invalid."
  end
  
  def test_should_have_a_author
    article = Article.new
    assert !article.valid?, "Article is not invalid."
    assert article.errors.invalid?(:author), "There is an Author where there should be none."
    assert article.errors.invalid?(:author_id), "The author_id is not invalid."
  end
  
  def test_should_belong_to_an_author
    article = articles(:article_with_author)
    assert_not_nil article.author, "Author should not be nil."
    assert_kind_of Author, article.author, "There should be an object of kind Author."
  end
  
  def test_should_save_with_valid_attributes
    assert_difference "Article.count", 1 do
      Article.create(:title => "Should Save", :content => "Should save content", :author => authors(:jessie))
    end
  end
  
  def test_should_create_anonymous_comment_for_article_if_no_author_is_given
    comment = articles(:article_with_comment).comments.build
    assert_kind_of AnonymousComment, comment
  end
  
  def test_should_create_author_comment_for_article_if_author_is_given
    comment = articles(:article_with_comment).comments.build({:content => "Content for Comment"}, authors(:jessie))
    assert_kind_of AuthorComment, comment
  end
  
  def test_should_only_delete_comments_if_given_author_is_author_of_article
    assert_difference "articles(:article_with_comment).comments.count", -1 do
      articles(:article_with_comment).comments.delete(comments(:first_comment), authors(:jessie))
    end
  end
  
  def test_should_raise_exception_if_author_trys_to_delete_comment_and_is_not_author_of_article
    assert_raise(Article::CommentDeletionNotAllowed) do
      articles(:article_with_comment).comments.delete(comments(:first_comment), authors(:author_with_articles))
    end
  end
end
