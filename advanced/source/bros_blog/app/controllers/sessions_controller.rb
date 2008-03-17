class SessionsController < ApplicationController
  
  def new
    @author = Author.new
  end
  
  def create
    if @author = Author.authenticate(params[:author][:email], params[:author][:password])
      session.user = @author
      redirect_to articles_path
    else
      render
    end
  end
  
  def destroy
    reset_session
    redirect_to articles_path
  end
  
end
