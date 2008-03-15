class Price
  attr_reader :price_code
end

class ChildrenPrice < Price
  def price_code
    Movie::CHILDREN
  end
  
  def get_charge(days_rented)
    amount = 1.5
    amount += (days_rented - 3) * 1.5 if days_rented > 3
    return amount
  end
end

class NewReleasePrice < Price
  def price_code
    Movie::NEW_RELEASE
  end
  
  def get_charge(days_rented)
    return days_rented * 3
  end
end

class RegularPrice < Price
  def price_code
    Movie::REGULAR
  end
  
  def get_charge(days_rented)
    amount = 2
    amount += (days_rented - 2) * 1.5 if days_rented > 2
    return amount
  end
end