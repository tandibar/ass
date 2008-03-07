################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: comments_controller.rb
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

class CommentsController < ApplicationController
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create_comment ],
         :redirect_to => { :controller => :articles, :action => :list }

  def add_comment
    @comment = Article.find(params[:article_id]).comments.build
    render :update do |page| 
      page.replace_html "add_comment_to_article", :partial => "add_comment", :locals => { :article_id => params[:id] }
      page.visual_effect :slide_down, "add_comment_to_article", :duration => 0.5
    end
  end

  def create
    @comment = Article.find(params[:article_id]).comments.build(params[:comment])
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      @article = @comment.article
      render :update do |page|
        page.replace_html "comments_list", :partial => 'list_comments'
        page.visual_effect :highlight, "comment_#{@comment.id}", :duration => 1.0
        # page.replace_html "add_comment_to_article", :partial => 'articles/add_comment_link', :article_id => @article.id
        # page.visual_effect :highlight, "comment_#{comment.id}", :duration => 1.0
      end
    else
      render :update do |page| 
        page.replace_html "comment_add_form", :partial => "add_comment"
      end
    end
  end
  
end
