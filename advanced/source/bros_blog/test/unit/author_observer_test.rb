# File: test/unit/author_observer_test.rb

require File.dirname(__FILE__) + '/../test_helper'

class AuthorObserverTest < Test::Unit::TestCase
  
  def test_should_react_on_create_and_send_welcome_mail_to_author
    author = Author.new
    author.expects(:valid?).returns(true)
    AuthenticationMailer.expects(:deliver_welcome_mail).with(author)
    
    author.save
  end
  
end