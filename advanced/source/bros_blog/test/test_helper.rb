ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'mocha'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  def disable_validations
    ActiveRecord::Base.disable_validation!
    yield
    ActiveRecord::Base.enable_validation!    
  end
  
  def login_user
    @request.session[:user] = authors(:jessie)
  end
  
end


module ValidationDisabler
  
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      alias_method_chain :valid?, :disable_check
    end
  end
  
  def valid_with_disable_check?
    return self.class.validation_disabled? || valid_without_disable_check?
  end
  
  module ClassMethods

    def disable_validation!
      @@disable_validation = true
    end

    def enable_validation!
      @@disable_validation = false
    end
    
    def validation_disabled?
      @@disable_validation ||= false
    end
    
  end
end

class ActiveRecord::Base
  include ValidationDisabler
end
