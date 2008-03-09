################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: article_test.rb
# Author: Andreas Bade
#
# Copyright (c) 2007 RailsBros.de
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
################ Copyright end ##################

require File.dirname(__FILE__) + '/../test_helper'

class ArticleTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_should_self
    assert true
  end
  
  def test_should_have_articles_of_today_for_listing
    Article.todays.each do |article|
      assert article.created_at.strftime("%Y-%m-%d") >= Time.now.midnight.strftime("%Y-%m-%d")
    end
  end
  
  def test_should_have_articles_of_yesterdays_for_listing
    Article.yesterdays.each do |article|
      assert article.created_at.strftime("%Y-%m-%d") < Time.now.midnight.strftime("%Y-%m-%d")
      assert article.created_at.strftime("%Y-%m-%d") >= Time.now.midnight.yesterday.strftime("%Y-%m-%d")
    end
  end
  
  def test_should_have_articles_older_then_yesterdays_for_listing
    Article.older_then_yesterdays.each do |article|
      assert article.created_at.strftime("%Y-%m-%d") < Time.now.midnight.yesterday.strftime("%Y-%m-%d")
    end
  end
  
  def test_should_have_many_comments
    article = articles(:first)
    
    assert_not_nil article
    assert_not_nil article.comments
    assert !article.comments.empty?
  end
  
  def test_should_get_more_comments
    assert_difference("articles(:first).comments.count") do
      articles(:first).comments.create(:author  => "Dirk Breuer",
                                       :email   => "dbreuer@email.com",
                                       :content => "Test Content!")
    end
  end
  
  def test_should_have_valid_title
    article = Article.new(:title => '')
    article.author = users(:jessie)
    assert !article.valid?
    article.title = "<script>javascript:alert('Hallo');</script>"
    assert !article.valid?
    article.title = " Valid"
    assert !article.valid?
    article.title = "Valid"
    assert article.valid?
    article.title = "Valid Test"
    assert article.valid?
    assert_valid article
    assert article.save
  end
  
  def test_should_be_taggable
    article = articles(:second)
    tags_size = article.tags.size
    article.tags << tags(:ruby)
    assert_valid article
    assert article.save
    assert_not_nil article.reload
    assert_not_nil article.tags
    assert article.tags.size > 0
    assert_equal tags_size+1, article.tags.size
  end
  
  def test_should_search_by_given_search_criteria
    expected_articles = Article.find(:all, :conditions => ['title LIKE ? OR content LIKE ?', '%Just%', '%Just%'])
    found_articles = Article.search_by_criteria('Just')
    assert_not_nil expected_articles
    assert !expected_articles.empty?
    assert_kind_of Array, expected_articles

    assert_not_nil found_articles
    assert !found_articles.empty?
    assert_kind_of Array, found_articles
    
    found_articles.each do |article|
      assert expected_articles.include?(article)
    end
  end
  
  def test_should_find_articles_by_tag_name
    rails_tag = tags(:rails)
    assert_not_nil rails_tag
    assert !rails_tag.articles.empty?
    assert_kind_of Array, rails_tag.articles
    
    found_articles = Article.find_by_tag_name('Rails')
    assert_not_nil found_articles
    assert !found_articles.empty?
    assert_kind_of Array, found_articles
    
    found_articles.each do |article|
      assert rails_tag.articles.include?(article)
    end
  end

  def test_should_find_nothing_for_invalid_tag
    found_articles = Article.find_by_tag_name('non_existing_tag_name')
    assert_not_nil found_articles
    assert_kind_of Array, found_articles
    assert found_articles.empty?
  end
  
  def test_should_find_articles_by_multiple_tags
    found_articles = Article.find_by_tag_name('Ruby+Rails')
    assert_not_nil found_articles
    assert_kind_of Array, found_articles
    assert !found_articles.empty?
    assert Article.find(:all, :conditions => ['tag_id = ? AND tag_id = ?', tags(:rails).id, tags(:ruby).id], :include => :tags).size, found_articles.size
  end
  
  def test_should_delete_comments_associated_with_article_on_delete
    article = articles(:first)
    assert_not_nil article
    assert_not_nil article.comments
    assert article.comments.size > 0
    comments_in_db = Comment.count
    size_of_comments_of_article = article.comments.size
    assert article.destroy
    assert_equal comments_in_db - size_of_comments_of_article, Comment.count
  end
  
  def test_should_override_default_to_param_method_with_id_and_urlfriendly_title
    article = articles(:first)
    assert_not_nil article
    assert_match /\d*-\w+/, article.to_param
  end
end
