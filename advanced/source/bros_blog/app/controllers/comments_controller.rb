class CommentsController < ApplicationController

  before_filter :author_logged_in, :except => [ :index, :new, :create ]
  
  # GET /comments
  # GET /comments.xml
  def index
    respond_to do |format|
      format.html { render :template => 'layouts/404', :status => 404 }
      format.xml  do
        @comments = Article.find(params[:article_id]).comments
        render :xml => @comments
      end
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Article.find(params[:article_id]).comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  # TODO: perhaps editing is possible for logged in authors?
  # perhaps just for a short time(one hour)?
  # GET /comments/1/edit
  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Article.find(params[:article_id]).comments.build(params[:comment], session[:user])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(article_path(:id => @comment.article.id)) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    begin
      Article.find(params[:article_id]).comments.delete(Comment.find(params[:id]), session[:user])
      respond_to do |format|
        format.html { redirect_to(article_comments_url(params[:article_id])) }
        format.xml  { head :ok }
      end
    rescue Article::CommentDeletionNotAllowed
      render :template => "layouts/401", :status => 401
    end
  end
end
