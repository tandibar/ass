require File.dirname(__FILE__) + '/test_env'

class CustomerTest < Test::Unit::TestCase
  
  def test_create_customer_with_name
    customer = Customer.new("Hans Wurst")
    assert customer
    assert_equal "Hans Wurst", customer.name
  end
  
  def test_add_rental
    assert Customer.new("Hans Wurst") << Rental.new(Movie.new("Die Hard 2", 2), 2)
  end
  
  def test_name_setter_is_private
    customer = Customer.new("Hans Wurst")
    assert_raise(NoMethodError) { customer.name = "heiße doch anders" }
  end
  
  def test_statement_creation_with_one_rental
    customer = Customer.new("Hans Wurst")
    customer << Rental.new(Movie.new("Die Hard 2", 0), 2)
    
    assert_equal "Rental Record for Hans Wurst\n\tDie Hard 2\t2\nAmount owed is 2.0\nYou earnd 1 frequent renter points", customer.statement
  end
  
  def test_statement_creation_with_different_rentals
    customer = Customer.new("Die Hard Fan with Kid")
    customer << Rental.new(Movie.new("Die Hard", 0), 2)
    customer << Rental.new(Movie.new("Die Hard 2", 0), 2)
    customer << Rental.new(Movie.new("Die Hard 3", 0), 2)
    customer << Rental.new(Movie.new("Die Hard 4", Movie::NEW_RELEASE), 2)
    customer << Rental.new(Movie.new("Pocahontas", Movie::CHILDREN), 2)
    
    
    assert_equal "Rental Record for Hans Wurst\n\tDie Hard 2\t2\nAmount owed is 2.0\nYou earnd 1 frequent renter points", customer.statement
  end
end