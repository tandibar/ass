################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: comments_controller_test.rb
# Author: Dirk Breuer
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
require 'comments_controller'

# Re-raise errors caught by the controller.
class CommentsController; def rescue_action(e) raise e end; end

class CommentsControllerTest < Test::Unit::TestCase
  def setup
    @controller = CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_should_self
    assert true
  end
  
  def test_should_add_and_create_comment_to_existing_article
    assert_difference ("Comment.count") do
      xhr :post, :create, :comment => { "author" => "ME", "email" => "me@test.de", "content" => "Test Text for fun" }, :article_id => articles(:first)
    end
    
    assert_response :success
    assert_template '_list_comments'
    assert_not_nil assigns(:article)
    assert_not_nil assigns(:article).comments
    assert !assigns(:article).comments.empty?
  end
  
  def test_should_not_create_comment_without_article
    
  end
end
