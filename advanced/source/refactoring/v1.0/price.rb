class Price
  attr_reader :price_code
end

class ChildrenPrice < Price
  def price_code
    Movie.CHILDREN
  end
end

class NewReleasePrice < Price
  def price_code
    Movie.NEW_RELEASE
  end
end

class RegularPrice < Price
  def price_code
    Movie.REGULAR
  end
end