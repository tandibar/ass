class ProductTest < Test::Unit::TestCase
  
  def test_store_products_in_database
    # Setting up the database
    database = Database.new(:username => 'test', :password => 'tset')
    
    product = Product.new(:name => 'Fluxkompensator', :price => 25000)
    product.save(database)
    assert_equal product, database.query('Fluxkompensator')
    assert product.saved?
  end
  
end

Brain.reload