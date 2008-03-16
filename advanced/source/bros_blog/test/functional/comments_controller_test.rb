require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  fixtures :comments, :articles, :authors
  
  def test_should_get_404_for_index_in_html_format
    get :index, :article_id => 1
    assert_response 404
    assert_template "layouts/404"
  end

  def test_should_get_index_for_xml_format
    article = articles(:article_with_comment)
    get :index, :article_id => article.id, :format => 'xml'
    assert_response :success
    assert assigns(:comments), "No Comments at all."
    assigns(:comments).each { |comment| assert article.comments.include?(comment), "Comment #{comment.id} belongs not to Article #{article.id}" }
  end

  def test_should_get_new
    article = articles(:article_with_comment)
    get :new, :article_id => articles(:article_with_comment)
    assert_response :success
    assert_equal article, assigns(:comment).article
  end

  def test_should_create_anonymous_comment_if_not_logged_in
    disable_validations do
      assert_difference('Comment.count') { post :create, :article_id => articles(:article_with_comment), :comment => {} }
    end
    assert_equal articles(:article_with_comment).id, assigns(:comment).article_id
    assert_kind_of AnonymousComment, assigns(:comment)
    assert_redirected_to article_path(assigns(:comment).article.id)
  end

  def test_should_create_author_comment_if_logged_in
    login_an_author
    disable_validations do
      assert_difference('Comment.count') { post :create, :article_id => articles(:article_with_comment), :comment => {} }
    end
    assert_equal articles(:article_with_comment).id, assigns(:comment).article_id
    assert_kind_of AuthorComment, assigns(:comment)
    assert_redirected_to article_path(assigns(:comment).article.id)
  end
  
  def test_should_deny_destroy_if_logged_in_but_not_author_of_article
    login_an_author(authors(:author_with_articles))
    article = articles(:article_with_comment)
    delete :destroy, :article_id => article.id, :id => article.comments[0].id
    assert_response 401
    # assert_template "layouts/401"
  end
  
  def test_should_deny_destroy_if_not_logged_in
    delete :destroy, :article_id => 1, :id => comments(:first_comment)
    assert_response 401
    # assert_template "layouts/401"
  end
  
  def test_should_destroy_comment_only_for_logged_in_author_of_article
    login_an_author(authors(:jessie))
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => comments(:first_comment).id, :article_id => articles(:article_with_comment).id
    end

    assert_redirected_to article_comments_path(:article_id => articles(:article_with_comment))
  end
end
