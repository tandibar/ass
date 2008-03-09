# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '11130c1aa17cb509099185cc9f30f41e'
  
  protected
    
    def author_logged_in
      unless session[:user]
        render :template => "layouts/401", :status => 401
      else
        true
      end
    end
  
end

module SessionUserExtension
end

class ActionController::Base
  # include SessionUserExtension
  class << session
    def user=(user)
      reset_session
      session[:user] ||= {}
      session[:user][:id], session[:user][:class] = user.id, user.class
    end
    
    def user
      session[:user][:class].camelize.constanize.send(:find, session[:user][:id])
    end
  end
end