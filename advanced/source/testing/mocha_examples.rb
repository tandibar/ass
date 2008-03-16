require 'test/unit'
require 'mocha'

class ArticlesControllerTest < Test::Unit::TestCase

  def test_should_list_all_articles_on_index_action
    Article.expects(:find).with(:all).returns([])
    get :index
    assert_response :success, @response.body
  end
  
  def test_should_display_title_and_content_on_show_action
    article = Article.new
    article.expects(:title).returns("Mocking with mocha")
    article.expects(:content).returns("The content for this post ...")
    Article.expects(:find).with('1').returns(article)
    get :show, :id => 1
    assert_response :success, @response.body
    assert_template 'show'
  end
  
end