class ProductTest < Test::Unit::TestCase
  
  def test_store_products_in_database
    # Setting up the database
    database = Database.new
    database.expects(:save).with(:product).returns(:true)
    
    product = Product.new(:name => 'Fluxkompensator', :price => 25000)
    product.save(database)
    assert product.saved?
  end
  
end