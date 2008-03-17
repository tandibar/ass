require File.dirname(__FILE__) + '/../test_helper'

class ArticlesControllerTest < ActionController::TestCase
  fixtures :articles, :authors

  def test_should_get_index
    article = Article.new
    author = Author.new
    author.expects(:email).returns('test@email.com')
    article.expects(:author).returns(author)
    article.expects(:created_at).returns(Time.now)
    article.expects(:comments).returns(mock(:count => 2))
    Article.expects(:find).with(:all).returns([article])
    
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end
  
  def test_should_deny_access_to_new
    get :new
    assert_response 401
    # assert_template "layouts/401"
  end

  def test_should_get_new_if_logged_in
    login_an_author
    get :new
    assert_response :success
  end

  def test_should_deny_access_to_create
    post :create, :article => {  }
    assert_response 401
    # assert_template "layouts/401"
  end
  
  def test_should_create_article
    login_an_author(authors(:jessie))
    get :index # This is required to init the session and the controller
    disable_validations do
      assert_difference("@controller.session.user.articles.count") { post :create, :article => { } }
    end
    assert_redirected_to article_path(assigns(:article))
  end

  def test_should_show_article
    get :show, :id => articles(:article_with_comment)
    assert_response :success
  end
  
  def test_should_deny_access_to_edit
    get :edit, :id => 1
    assert_response 401
    # assert_template "layouts/401"
  end
  
  def test_should_get_edit_if_logged_in
    login_an_author
    Article.expects(:find).with("1").returns(Article.new)
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_deny_access_to_update
    put :update, :id => 1
    assert_response 401
    # assert_template "layouts/401"
  end

  def test_should_update_article
    login_an_author
    article = Article.new
    Article.expects(:find).with("1").returns(article)
    article.expects(:update_attributes).with("title" => "Mocking Title to save").returns(true)
    put :update, :id => 1, :article => { :title => "Mocking Title to save" }
    assert_redirected_to article_path(assigns(:article))
  end

  def test_should_deny_access_to_destroy
    delete :destroy, :id => 1
    assert_response 401
    # assert_template "layouts/401"
  end

  def test_should_destroy_article
    login_an_author
    article = Article.new
    Article.expects(:find).with("1").returns(article)
    article.expects(:destroy)
    delete :destroy, :id => 1

    assert_redirected_to articles_path
  end
  
end
