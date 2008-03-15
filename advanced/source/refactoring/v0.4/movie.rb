class Movie
  
  CHILDREN = 2
  REGULAR = 0
  NEW_RELEASE = 1
  
  attr_accessor :price_code
  attr_reader :title
  
  def initialize(title, price_code)
    @title = title
    @price_code = price_code
  end
  
  private
    attr_writer :title
  
end