require File.dirname(__FILE__) + '/../test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  fixtures :articles, :authors, :images
  
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
  
  def test_should_have_an_image
    article = articles(:article_with_image)
    assert_not_nil article.image, "Image should not be nil."
    assert_kind_of Image, article.image, "There should be an object of kind Image."
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
  
end
