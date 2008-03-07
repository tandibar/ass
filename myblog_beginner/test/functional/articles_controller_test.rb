################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: articles_controller_test.rb
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
require 'articles_controller'

# Re-raise errors caught by the controller.
class ArticlesController; def rescue_action(e) raise e end; end

class ArticlesControllerTest < ActionController::TestCase

  def test_should_list_last_ten_articles_by_calling_the_index_action
    get :index
    assert_response :success
    assert_template 'index'

    assert_not_nil assigns(:articles)
    assert_equal 10, assigns(:articles).size
  end

  def test_should_show_single_article_by_providing_id_plus_any_text
    get :show, :id => articles(:first)

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:article)
    assert_equal articles(:first), assigns(:article)
  end

  def test_should_render_form_for_new_article_on_new_action
    login
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:article)
  end
  
  def test_should_create_a_new_article_and_redirect_to_the_index
    login
    assert_difference('Article.count') do
      post :create, :article => {:title => "Title for Test"}
    end

    assert_redirected_to :action => 'index'
  end
  
  def test_should_render_new_template_for_non_valid_article
    login
    post :create, :article => {}
    
    assert_response :success, @response.body
    assert_template 'new'
  end

  def test_should_get_edit_form_for_article_and_have_correct_article_assigned
    login
    get :edit, :id => articles(:first).id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:article)
    assert_equal articles(:first), assigns(:article)
  end

  def test_should_update_article_if_logged_in
    login
    put :update, :id => articles(:first), :article => {:title => "Test Update"}
    assert_redirected_to article_path(articles(:first).reload)
    assert_equal Article.find(articles(:first).id).title, "Test Update"
  end
  
  def test_should_render_edit_form_for_invalid_article_to_update
    login
    put :update, :id => articles(:first), :article => { :title => '' }

    assert_response :success, @response.body
    assert_template 'edit'
  end
  
  def test_should_not_update_article_if_not_logged_in
    put :update, :id => articles(:first), :article => {:title => "Test Update"}
    assert_redirected_to login_path
  end

  def test_should_destroy
    login
    assert_difference('Article.count', -1) do
      delete :destroy, :id => articles(:first).id
    end
    
    assert_redirected_to articles_path
  end
  
  def test_should_perform_search_with_ajax
    xhr :post, :search, :search_string => 'Just'
    
    assert_response :success
    assert_template '_complete_article_list'
    assert_not_nil assigns(:articles)
    assert assigns(:articles).size > 0
    assert Article.find(:all, :conditions => ['title LIKE ?', '%Just%']).size, assigns(:articles).size
  end
  
  def test_should_perform_search_without_ajax
    post :search, :search_string => 'Just'
    
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:articles)
    assert assigns(:articles).size > 0
    assert Article.find(:all, :conditions => ['title LIKE ?', '%Just%']).size, assigns(:articles).size
  end
  
  def test_should_add_tags_to_article
    login
    num_of_rails_tags = Tag.find_by_name('Rails').articles.size
    num_of_ruby_tags = Tag.find_by_name('Ruby').articles.size
    num_of_articles = Article.find(:all).size
    
    post :create, :article => {:title => "Title for Tag Test", :tags_as_string => "Ruby Rails"}
    
    assert_response :redirect
    assert_redirected_to :action => 'index'

    assert_equal num_of_articles+1, Article.find(:all).size
    
    tagged_article =  Article.find_by_title('Title for Tag Test')
    assert_not_nil tagged_article
    assert_not_nil tagged_article.tags
    assert_equal 2, tagged_article.tags.size
    
    assert_equal num_of_rails_tags+1, Tag.find_by_name('Rails').articles.size
    assert_equal num_of_ruby_tags+1, Tag.find_by_name('Ruby').articles.size

    # test with edit action
    num_of_rails_tags = Tag.find_by_name('Rails').articles.size
    num_of_ruby_tags = Tag.find_by_name('Ruby').articles.size
    
    assert articles(:first).tags.include?(tags(:ruby))
    assert articles(:first).tags.include?(tags(:rails))
    
    put :update, :id => articles(:first).id, :article => {:title => "Title for Tag Test", :tags_as_string => "Ruby Rails Geek"}
    
    assert_response :redirect
    assert_redirected_to :action => 'show'
    
    tagged_article =  Article.find_by_title('Title for Tag Test')
    assert_not_nil tagged_article
    assert_not_nil tagged_article.tags
    assert_equal 3, tagged_article.tags.size
    
    assert_equal num_of_rails_tags, Tag.find_by_name('Rails').articles.size
    assert_equal num_of_ruby_tags, Tag.find_by_name('Ruby').articles.size
    assert_equal 1, Tag.find_by_name('Geek').articles.size
  end
  
  def test_should_provide_no_access_to_sensitive_actions
    get :new
    assert_response :redirect
  end
  
  def test_should_have_pretty_url_for_given_tags
    assert_routing '/tags/Ruby+Rails', :controller => 'articles', :action => 'index', :tags => 'Ruby+Rails'
  end
  
  def test_should_find_articles_by_tags_and_list_them
    get :index, :tags => "Rails+Ruby"

    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:articles)
    assert assigns(:articles).size > 0
    assert Article.find(:all, :conditions => ['tag_id = ? AND tag_id = ?', tags(:rails).id, tags(:ruby).id], :include => :tags), assigns(:articles)
  end

  def test_should_not_throw_any_error_without_valid_tag_but_render_a_message
    get :index, :tags => "invalid tag"

    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:articles)
    assert assigns(:articles).empty?, "No Articles in the view!"
    assert_not_nil flash
    assert_not_nil flash['notice']
    assert_equal "No articles for this Tag!", flash['notice']
  end
  private
  
    def login
      @request.session[:user] = users(:jessie)
    end
end
