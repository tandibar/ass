# File: test/unit/authentication_mailer_test.rb

require File.dirname(__FILE__) + '/../test_helper'

class AuthenticationMailerTest < ActionMailer::TestCase
  def test_should_deliver_welcome_mail_to_user
    ActionMailer::Base.deliveries = []
    
    author = Author.new
    author.expects(:firstname).at_most(2).returns('Peter')
    author.expects(:lastname).returns('Parker')
    author.expects(:email).returns('peter.parker@gmail.com')
    AuthenticationMailer.deliver_welcome_mail(author)
    
    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries.first
    assert_equal "no-reply@railsbros.de", mail.from.first
    assert_equal "peter.parker@gmail.com", mail.to.first
    assert_equal "Welcome Peter to the Railsbrothers Blog", mail.subject
    assert_match /Peter Parker/, mail.body
    assert_match /Your Rails Brothers Team/, mail.body
  end
end