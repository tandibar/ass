# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticationSystem
  
  layout "master"
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '11130c1aa17cb509099185cc9f30f41e'
  
  protected
    
    def author_logged_in
      unless session.user
        render :template => "layouts/401", :status => 401
      else
        true
      end
    end
  
end