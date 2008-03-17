# File: app/models/authentication_mailer.rb

class AuthenticationMailer < ActionMailer::Base
  
  def welcome_mail(author)
    @subject    = "Welcome #{author.firstname} to the Railsbrothers Blog"
    @from       = "no-reply@railsbros.de"
    @recipients = author.email
    @body       = { :author => author }
  end
  
end