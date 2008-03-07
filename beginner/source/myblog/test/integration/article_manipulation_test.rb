require "#{File.dirname(__FILE__)}/../test_helper"

class ArticleManipulationTest < ActionController::IntegrationTest

  def test_should_login_create_article_and_logout
    # Go to the home page
    get articles_path
    
    assert_response :success, @response.body
    assert_template 'articles/index'
    
    # Try to create an Article without login ...
    post articles_path, :article => { :title => "Integration Testing rocks",
                                      :content => "This is one cool shit we got here!" }
    assert_redirected_to login_path
    
    # Login the user, first time with wrong password ...
    post login_path, :user => { :email => users(:jessie).email, :password => 'wrong_password' }
    assert_response :success, @response.body
    assert_template 'users/login'
    # ... second time with correct password
    post login_path, :user => { :email => users(:jessie).email, :password => 'mypassword' }
    assert_redirected_to articles_path
    
    # Now create an article
    assert_difference('Article.count') do
      post articles_path, :article => { :title => "Integration Testing rocks",
                                        :content => "This is one cool shit we got here!" }
    end
    assert_redirected_to articles_path
    
    get 'users/logout'
    assert_nil session[:user]
  end
end
