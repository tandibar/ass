require File.dirname(__FILE__) + '/../test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def test_should_have_a_login_route
    assert_routing '/login', :controller => 'sessions', :action => 'new'
  end

  def test_should_have_a_logout_route
    assert_routing '/logout', :controller => 'sessions', :action => 'destroy'
  end
  
  def test_should_show_login_form_on_get_request
    get :new
    assert_response :success, @response.body
    assert_template 'new'
  end
  
  def test_should_login_an_user_with_correct_credentials
    author = Author.new(:email => 'susan.storm@fantasticfour.com')
    author.expects(:id).returns(1)
    Author.expects(:authenticate).with('susan.storm@fantasticfour.com', 'susans_password').returns(author)
    
    post :create, :author => {:email => 'susan.storm@fantasticfour.com', :password => 'susans_password'}
    assert_redirected_to articles_path
    assert_equal author, @controller.session.user
  end
  
  def test_should_logout_the_current_user
    login_an_author
    
    delete :destroy
    assert_redirected_to articles_path
    assert_raise(NoMethodError) { @response.session.user }
  end
  
end
