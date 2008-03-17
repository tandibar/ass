class AuthorsController < ApplicationController
  
  def new
    @author = Author.new
  end
  
  def create
    @author = Author.new(params[:author])
    if @author.save
      redirect_to author_path(@author)
    else
      render :action => "new"
    end
  end
  
end
