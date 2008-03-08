require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  fixtures :comments
  
  def test_should_get_404_for_index_in_html_format
    get :index, :article_id => 1
    assert_response 404
    assert_template "layouts/404"
  end

  def test_should_get_index_for_xml_format
    get :index, :article_id => 1, :format => :xml
    assert_response :success
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_comment
    assert_difference('Comment.count') do
      post :create, :comment => { }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  def test_should_show_comment
    get :show, :id => comments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => comments(:one).id
    assert_response :success
  end

  def test_should_update_comment
    put :update, :id => comments(:one).id, :comment => { }
    assert_redirected_to comment_path(assigns(:comment))
  end

  def test_should_destroy_comment
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => comments(:one).id
    end

    assert_redirected_to comments_path
  end
end
