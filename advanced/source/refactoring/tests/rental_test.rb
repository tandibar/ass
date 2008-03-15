require File.dirname(__FILE__) + '/test_env'

class RentalTest < Test::Unit::TestCase
  
  def test_create_rental_with_movie_and_days_rented
    movie = Movie.new("Die Hard", 1)
    rental = Rental.new(movie, 2)
    assert rental
    assert_equal movie, rental.movie
    assert_equal 2, rental.days_rented
  end
  
  def test_movie_setter_is_private
    rental = Rental.new(Movie.new("Die Hard", 1), 2)
    assert_raise(NoMethodError) { rental.movie = Movie.new("Die Hard 2", 2) }
  end
  
  def test_days_rented_setter_is_private
    rental = Rental.new(Movie.new("Die Hard", 1), 2)
    assert_raise(NoMethodError) { rental.days_rented = 3 }
  end
  
end