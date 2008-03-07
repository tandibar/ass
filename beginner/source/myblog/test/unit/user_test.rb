################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: user_test.rb
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

class UserTest < Test::Unit::TestCase

  # Replace this with your real tests.
  def test_should_self
    assert true
  end
  
  def test_should_create_new_valid_user
    user = User.new(:email => 'jenna.jamesson@boobs.com',
                    :lastname => 'Jamesson',
                    :firstname => 'Jenna')
                    
    assert user.new_record?
    user.password = "a_password_test"
    user.confirm_password = "a_password_test"
    assert_valid user
    assert user.save, user.errors.full_messages
  end
  
  def test_should_have_matching_passwords_on_create
    user = User.new
    user.password = "password"
    user.confirm_password = "do_not_match"
    assert !user.valid?
    assert user.errors.invalid?(:password)
  end
  
  def test_should_valid_user
    jessie = users(:jessie)
    assert_valid jessie
  end
  
  def test_should_authenticate_user
    jessie = users(:jessie)
    
    auth_user = User.authenticate(jessie.email, 'mypassword')
    assert_not_nil auth_user
    assert_equal jessie, auth_user
  end
  
  def test_should_not_authenticate_with_wrong_password
    jessie = users(:jessie)
    
    auth_user = User.authenticate(jessie.email, 'wrong')
    assert !auth_user
  end
end
