# File: app/models/author_observer.rb

class AuthorObserver < ActiveRecord::Observer
  
  def after_create(author)
    AuthenticationMailer.deliver_welcome_mail(author)
  end
  
end