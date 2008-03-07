################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: users_controller_test.rb
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
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < Test::Unit::TestCase

  def setup
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_profile
    @request.session[:user] = users(:jessie)
    get :profile

    assert_response :success
    assert_template 'profile'

    assert_not_nil assigns(:user)
    assert assigns(:user).valid?
  end

  def test_should_signup
    get :signup

    assert_response :success
    assert_template 'signup'

    assert_not_nil assigns(:user)
  end

  def test_should_create
    num_users = User.count

    post :create, :user => {:firstname => 'Luke',
                            :lastname => 'Skywalker',
                            :email => 'luke@skywalker.de',
                            :password => 'test_pass',
                            :confirm_password => 'test_pass'}

    assert_response :redirect, assigns(:user).errors.full_messages
    assert_redirected_to articles_path

    assert_equal num_users + 1, User.count
  end
  
  def test_should_login
    get :login
    
    assert_response :success
    assert_template 'login'
    
    post :login, :user => {:email => users(:jessie).email, :password => 'mypassword'}
    
    assert_response :redirect
    assert @response.has_session_object?(:user)
    assert_equal @response.session[:user], users(:jessie)
    RAILS_DEFAULT_LOGGER.debug "--> @response.session[:user]: #{@response.session[:user].inspect}"
  end
  
  def test_should_logout
    get :logout
    assert !@response.has_session_object?(:user)
  end

end
