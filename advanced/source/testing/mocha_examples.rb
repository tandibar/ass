require 'rubygems'
require 'test/unit'
require 'mocha'

class ArticlesControllerTest < Test::Unit::TestCase

  # Klassenmethoden mocken
  def test_should_list_all_articles_on_index_action
    Article.expects(:find).with(:all).returns([])
    get :index
    assert_response :success, @response.body
  end
  
  # Instanzmethoden mocken
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

# Aufwendigeres Beispiel mit Stubben auf allen Instanzen
class RemoteSystem
  
  def query_for_a_value_of_an_id(value, id)
    connection = establish_connection(configuration)
    result = connection.execute(Query.new(string))
    result.sort.first
  end
  
end

class Account
  
  attr_reader :system
  
  def initialize(any_system)
    @system = any_system
  end
  
  def balance
    system.query_for_a_value_of_an_id('balance', self.id)
  end
  
end

class AccountTest < Test::Unit::TestCase
  
  def test_should_get_balance_of_account_from_remote_system
    RemoteSystem.any_instance.stubs(:query_for_a_value_of_an_id).returns(100)
    account = Account.new(RemoteSystem.new)
    assert_equal 100, account.balance
  end
  
end

# 'Klassisches' Mocken
class Order
  def self.fetch_most_recent_order(database)
    database.query("SELECT * FROM orders ORDER BY created_at LIMIT 1")
  end
  
  # ... more Methods
end

class OrderTest < Test::Unit::TestCase
  
  def test_should_fetch_most_recent_order_from_database
    mock_database = mock('mock_database', :query => 'order')
    order = Order.fetch_most_recent_order(mock_database)
    assert_equal "order", order
  end
  
end