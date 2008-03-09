################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: application.rb
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

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  layout 'myblog' # The Layout for all pages

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_myblog_session_id'
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => "KfQf=oGqnJ36jn[#99)XQ6(<Zn][PcM.&%_PLWjrw>C8M,TG9@D0$VY/'(2xybf"
    
  def impressum
    render :template => "application/impressum"
  end
  
  protected
  
    def custom_paginator(collection, obj=:article, current_page=nil, items_per_page=10)
      current_page = current_page || (params[:page].nil? ? 1 : params[:page].to_i)
      max_element = collection.size
      max_page = (max_element/items_per_page).ceil
      sliced_collection = collection.slice((current_page-1)*items_per_page, items_per_page)

      pages = Paginator.new(obj, max_element, items_per_page, current_page)
      return pages, sliced_collection
    end
  
    def authenticated
      session[:user] ? true : redirect_to(login_path)
    end
end
