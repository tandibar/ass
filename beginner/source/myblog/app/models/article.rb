################ Copyright start #################
# 
# Project: ASS Ruby on Rails Workshop - MyBlog
# Filename: article.rb
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

class Article < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  
  has_many :comments, :dependent => :delete_all, :order => "created_at DESC"
  has_and_belongs_to_many :tags
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  
  validates_presence_of :title, :on => :save, :message => "can't be blank"
  validates_presence_of :user_id, :on => :save, :message => "must be owned by a User"
  validates_format_of :title, :with => /^\w+(\w|\s)*$/i
  
  before_save :clean_text_attrs
  
  after_save { logger.debug '### AFTER SAVE' }
  
  def uploaded_image=(image_file)
    logger.debug "##### image_file: #{image_file.class}"
    if image_file && !image_file.empty?
      file_name = base_part_of(image_file.original_filename) + (base_part_of(image_file.original_filename).split('.')[1] ? '' : '.' + image_file.content_type.chomp.split('/')[1])
      self.image_url = file_name
      self.image_name = base_part_of(image_file.original_filename) unless attribute_present?('image_name')
      save_image_file(image_file, file_name)
    end
  end
  
  def tags_as_string=(tags_as_string)
    tags_as_string.split(' ').each do |tag|
      real_tag = Tag.find_or_create_by_name(tag)
      self.tags << real_tag unless self.tags.include?(real_tag)
    end
  end
  
  def self.search_by_criteria(criteria)
    criteria = criteria.tr('\'', '').tr('%', '')
    find(:all, :conditions => ['title LIKE ? OR content LIKE ?', "%#{criteria}%", "%#{criteria}%"], :order => order_by)
  end
  
  def self.find_by_tag_name(tag_names)
    find(:all, :conditions => ['tags.name IN (?)', tag_names.split('+')], :include => :tags, :order => order_by)
  end
  
  def self.order_by
    "created_at DESC"
  end
  
  def self.todays
    find_in_timeframe(:from => Time.now.midnight)
  end

  def self.yesterdays
    find_in_timeframe(:from => Time.now.midnight.yesterday, :to => Time.now.midnight)
  end
  
  def self.older_then_yesterdays
    find_in_timeframe(:to => Time.now.midnight.yesterday)
  end
  
  # Overrides the default to_param method for permalink like urls
  def to_param
    "#{id}-#{title.gsub(/\s+/, '_')}"
  end
  
  private
  
    def self.find_in_timeframe(options)
      if options[:from] && options[:to]
        timeframe = ['created_at > ? AND created_at < ?', options[:from].to_s(:db), options[:to].to_s(:db)]
      elsif options[:to]
        timeframe = ['created_at < ?', options[:to].to_s(:db)]
      elsif options[:from]
        timeframe = ['created_at > ?', options[:from].to_s(:db)]
      end
      
      Article.find(:all, :conditions => timeframe, :limit => MAX_ARCHIVE_ELEMTS)
    end
  
    def save_image_file(image_file, file_name)
      image_data = image_file.read
      
      File.open(File.dirname(__FILE__) + UPLOAD_DIRECTORY + file_name, "wb") do |file|
        file.write(image_data)
      end if image_data
    end
    
    def base_part_of(file_name)
      File.basename(file_name).gsub(/[^\w\._-]/, '')
    end
    
    def clean_text_attrs
      attributes.each do |attr_name, attr_value|
        if self.send(attr_name).instance_of?(String)
          write_attribute(attr_name, sanitize(attr_value))
        end
      end
    end
  
end
