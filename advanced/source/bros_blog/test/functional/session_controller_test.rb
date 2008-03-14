require File.dirname(__FILE__) + '/../test_helper'

class SessionControllerTest < ActionController::TestCase
  
  def test_should_have_a_login_route
    assert_routing '/login', :controller => 'session', :action => 'login'
  end

  def test_should_have_a_logout_route
    assert_routing '/logout', :controller => 'session', :action => 'logout'
  end
  
  def test_should_show_login_form_on_get_request
    get :login
    assert_response :success, @response.body
    assert_template 'login'
  end
  
  def test_should_login_an_user_with_correct_credentials
    author = Author.new(:email => 'susan.storm@fantasticfour.com')
    author.expects(:id).returns(1)
    Author.expects(:authenticate).with('susan.storm@fantasticfour.com', 'susans_password').returns(author)
    
    post :login, :author => {:email => 'susan.storm@fantasticfour.com', :password => 'susans_password'}
    assert_redirected_to articles_path
    assert_equal author, @controller.session.user
  end
  
  def test_should_logout_the_current_user
    login_an_author
    
    post :logout
    assert_redirected_to articles_path
    assert_raise(NoMethodError) { @response.session.user }
  end
  
  private
    
    def login_an_author
      @controller.session.instance_variable_set(:@current_user, Author.new(:email => 'susan.storm@fantasticfour.com'))
    end
  
end
