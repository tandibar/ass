################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: articles_controller.rb
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

class ArticlesController < ApplicationController
  before_filter :authenticated, :only => [:edit, :update, :new, :create, :destroy]
                
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :create_comment ],
         :redirect_to => { :action => :index }
  verify :method => :put, :only => :update,
         :redirect_to => { :action => :index }
  verify :method => :delete, :only => :destroy,
         :redirect_to => { :action => :index }

  def index
    articles_to_display = find_articles_by_tags_in_param_or_all
    @article_pages, @articles = custom_paginator(articles_to_display)
    respond_to do |format|
      format.html
      format.rss { render :rss => @articles, :layout => false }
    end
  end
  
  def search
    @article_pages, @articles = custom_paginator(Article.search_by_criteria(params['search_string']))
    if request.xhr?
      render :update do |page|
        page.replace_html "complete_article_list", :partial => "complete_article_list"
      end
    else
      render :action => 'index'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    @article.author = session[:user]
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to articles_path 
    else
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to article_path(@article)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_path
  end
  
  private
  
    def find_articles_by_tags_in_param_or_all
      if tags = params['tags']
        articles = Article.find_by_tag_name(tags)
        articles.empty? and flash['notice'] = "No articles for this Tag!"
      else
        articles = Article.find(:all, :order => Article.order_by)
      end
      return articles
    end
end
