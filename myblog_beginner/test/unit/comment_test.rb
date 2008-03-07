################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: comment_test.rb
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

class CommentTest < Test::Unit::TestCase

  # Replace this with your real tests.
  def test_should_self
    assert true
  end
  
  def test_should_create_comment
    new_comment = Comment.new(:author => "Jessie Summers")
    assert_not_nil new_comment
    assert !new_comment.valid?
    new_comment.article = articles(:first)
    assert_valid new_comment
    assert new_comment.save
  end
  
  def test_should_have_valid_email
    new_comment = Comment.new(:author => "Jessie Summers")
    new_comment.article = articles(:first)
    assert_valid new_comment
    
    new_comment.email = "invalid"
    assert !new_comment.valid?
    new_comment.email = "test@domain"
    assert !new_comment.valid?
    new_comment.email = "test.domain/"
    assert !new_comment.valid?
    new_comment.email = "invalud email@gmx.de"
    assert !new_comment.valid?
    new_comment.email = "valid.email@test.com"
    assert_valid new_comment
    assert new_comment.save
  end
  
  def test_should_have_either_email_or_author_name_filled
    new_comment = Comment.new
    new_comment.article = articles(:first)
    assert !new_comment.valid?
    
    new_comment.email = "valid.email@test.com"
    assert_valid new_comment
    new_comment.email = nil
    assert !new_comment.valid?
    new_comment.author = "Mike Mayers"
    assert_valid new_comment
    
    assert new_comment.save
  end
  
  def test_should_have_article_that_exists
    new_comment = Comment.new(:author => "Jessie Summers")
    assert !new_comment.valid?
    new_comment = Comment.new(:author => "Jessie Summers", :article => nil)
    assert !new_comment.valid?
    new_comment = Comment.new(:author => "Jessie Summers", :article_id => -1)
    assert !new_comment.valid?
    new_comment = Comment.new(:author => "Jessie Summers", :article_id => 300)
    assert !new_comment.valid?
    new_comment = Comment.new(:author => "Jessie Summers", :article_id => 2)
    assert_valid new_comment
  end
end
