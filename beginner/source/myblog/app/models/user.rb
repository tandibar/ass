################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: user.rb
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

require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :articles, :class_name => "Article", :foreign_key => "user_id"
  
  validates_presence_of :email
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :password
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_format_of :firstname, :with => /\w+/
  validates_format_of :lastname, :with => /\w+/
  validates_uniqueness_of :email
  validates_length_of :password, :within => 5..20, :on => :save, :message => "must be at least 5 and max 20 Characters long", :if => Proc.new { |user| user.new_record? }

  # after_save '@new_password = false'
  before_save :crypt_password

  attr_accessor :confirm_password

  # def initialize(attributes = nil)
  #   super
  #   @new_password = true
  # end
  
  def self.authenticate(email, password)
    u = User.find_by_email(email)
    # u ? User.find_by_email(email, :conditions => ['password = ?', hashed(password, u.salt)]) : false
    (u && u.password == hashed(password, u.salt)) ? u : false
  end
  
  def full_name
    self.firstname + ' ' + self.lastname
  end
  
  protected
    
    def validate_on_create
      if new_record? && password != confirm_password
        errors.add('password', "The entered passwords do not match!")
        # errors.add('confirm_password', "The entered password do not match!")
      end
    end
  
  private
  
    def generate_salt
      self.salt = "#{rand.to_s}-salt-ljkhcawb4-#{Time.now}"
    end
  
    def crypt_password
      generate_salt
      self.password = self.class.hashed(self.password, self.salt)
    end
    
    def self.hashed(str, salt)
      Digest::SHA1.hexdigest("#{str}#{salt}")
    end
  
end