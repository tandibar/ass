require File.dirname(__FILE__) + '/../test_helper'

class AuthorsControllerTest < ActionController::TestCase

  def test_should_have_signup_route
    assert_routing '/signup', :controller => 'authors', :action => 'new'
  end

  def test_should_show_signup_page
    get :new
    assert_response :success, @response.body
    assert_template 'new'
  end
  
  def test_should_signup_new_author_and_send_confirmation_email
    assert_difference "Author.count", 1 do
      create_user
    end
  end
  
  def test_should_not_signup_if_author_to_signup_is_invalid
    assert_no_difference "Author.count" do
      post :create
      assert_response :success, @response.body
      assert_template 'new'
    end
  end
  
  def test_should_not_activate_without_activation_key
    assert_raise(ActionController::RoutingError) { post :activation }
  end
  
  protected
  
    def create_user
      post :create, :author => {:firstname => 'Richard', :lastname => 'Reed', :email => 'richard.reed@ff.org', :email_confirmation => 'richard.reed@ff.org', :password => 'password', :password_confirmation => 'password' }
      assert_redirected_to author_path(assigns(:author))
    end
    
  
end
