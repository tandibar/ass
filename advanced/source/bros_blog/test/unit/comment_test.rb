require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  
  fixtures :comments

  def test_should_belong_to_an_article
    comment = comments(:first_comment)
    assert_not_nil comment.article, "Aricle should not be nil."
    assert_kind_of Article, comment.article
  end
  
  def test_should_have_an_article
    comment = Comment.new
    assert !comment.valid?, "Comment is not invalid."
    assert comment.errors.invalid?(:article), "There is an Article where there should be none."
    assert comment.errors.invalid?(:article_id), "The article_id is not invalid."
  end
  
  def test_should_have_a_content
    comment = Comment.new
    assert !comment.valid?, "Comment should be invalid."
    assert comment.errors.invalid?(:content), "Content is not invalid."
  end
  
  def test_might_have_a_homepage
    assert_nothing_raised(NoMethodError) { Comment.new(:homepage => 'http://railsbros.de') }
  end
  
  def test_should_have_valid_formatted_url_for_homepage
    comment = Comment.new(:homepage => 'http://www.railsbros.de')
    comment.valid?
    assert !comment.errors.invalid?(:homepage), "Homepage is not valid as it should be."
  end
  
  def test_should_deny_malformed_url_for_homepage
    comment = Comment.new

    invalid_urls = ['ftp://www', 'www://ftp.de', 'torrent://test.de', 'htt://railsbros', 'http//railsbros.de']
    
    invalid_urls.each do |url|
      comment.homepage = url
      comment.valid?
      assert comment.errors.invalid?(:homepage), "Homepage is not invalid as it should be with url: #{url}"
    end
  end
  
end
