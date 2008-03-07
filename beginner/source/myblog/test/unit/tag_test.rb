################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: tag_test.rb
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

class TagTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_should_self
    assert true
  end
  
  def test_should_has_many_articles
    rails_tag = tags(:rails)
    assert_not_nil rails_tag
    assert_not_nil rails_tag.articles
    assert rails_tag.articles.size > 0
    tagged_articles = Article.find(:all, :conditions => ['tag_id = ?', 1], :include => :tags).size
    assert_equal tagged_articles, rails_tag.articles.size
    
    rails_tag.articles << Article.find(104)
    assert rails_tag.save
    assert_equal tagged_articles+1, rails_tag.articles(true).size
  end
  
  def test_should_have_name
    new_tag = Tag.new()
    assert !new_tag.valid?
    new_tag.name = 'testing'
    assert_valid new_tag
  end
  
  def test_should_provide_list_of_all_tags
    assert_equal Tag.find(:all), Tag.list
  end
end
