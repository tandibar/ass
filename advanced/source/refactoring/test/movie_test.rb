require File.dirname(__FILE__) + '/test_env'

class MovieTest < Test::Unit::TestCase
  
  def test_create_movie_with_title_and_price_code
    m = Movie.new("testtitle", 1)
    assert m
    assert_equal "testtitle", m.title
    assert_equal 1, m.price_code
  end
  
  def test_title_setter_is_private
    m = Movie.new("testtitle", 1)
    assert_raise(NoMethodError) { m.title = "hanswurst" }
  end
  
  def test_price_code_can_be_changed
    m = Movie.new("testtitle", 1)
    assert m.price_code = 2
    assert_equal 2, m.price_code
  end

end