class Movie
  
  CHILDREN = 2
  REGULAR = 0
  NEW_RELEASE = 1
  
  attr_accessor :price
  attr_reader :title
  
  def initialize(title, price_code)
    @title = title
    self.price_code = price_code
  end
  
  def price_code
    price.price_code
  end
  
  def price_code=(price_code)
    case price_code
    when REGULAR
      self.price = RegularPrice.new
    when NEW_RELEASE
      self.price = NewReleasePrice.new
    when CHILDREN
      self.price = ChildrenPrice.new
    else
      raise IllegalArgumentException, "You provided an illegal price_code: #{price_code}"
    end
  end
  
  def get_charge(days_rented)
    price.get_charge(days_rented)
  end
  
  def get_frequent_renter_points(days_rented)
    (price_code == NEW_RELEASE && days_rented > 1) ? 2 : 1
  end
  
  private
    attr_writer :title
  
end