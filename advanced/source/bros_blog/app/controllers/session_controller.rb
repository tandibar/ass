class SessionController < ApplicationController
  
  def login
    if request.get?
      @author = Author.new
      render
    else
      logger.debug "##### params[:author]: #{params[:author].inspect}"
      if @author = Author.authenticate(params[:author][:email], params[:author][:password])
        session.user = @author
        redirect_to articles_path
      else
        render
      end
    end
  end
  
  def logout
    reset_session
    redirect_to articles_path
  end
  
end
