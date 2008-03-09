################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: users_controller.rb
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

class UsersController < ApplicationController
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :controller => :articles, :action => :list }

  def profile
    @user = User.find(session[:user])
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      session[:user] = @user.reload
      redirect_to articles_path
    else
      render :action => 'signup'
    end
  end

  def login
    if request.get?
      @user = User.new
    elsif request.post?
      u = User.authenticate(params[:user]['email'], params[:user]['password'])
      if u
        session[:user] = u
        flash[:notice] = "Login successful"
        redirect_to articles_path
      else
        flash[:notice] = "Login failed. Plese check password/username."
      end
    end
  end
  
  def logout
    reset_session
    flash[:notice] = "Logout successful"
    redirect_to :controller => 'articles', :action => 'list'
  end

end
