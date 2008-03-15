class Customer
  
  attr_reader :name
  
  def initialize(name)
    @name = name
    @rentals = []
  end
  
  def <<(rental)
    @rentals << rental
  end
  
  def statement
    
    total_amount = 0.0
    frequent_renter_points = 0
    
    result = "Rental Record for #{name}:\n"
    
    rentals.each do |current|
      this_amount = 0

      case current.movie.price_code
      when Movie::REGULAR
        this_amount += 2
        this_amount += (current.days_rented - 2) * 1.5 if current.days_rented > 2
      when Movie::NEW_RELEASE
        this_amount += current.days_rented * 3
      when Movie::CHILDREN
        this_amount += 1.5
        this_amount += (current.days_rented - 3) * 1.5 if current.days_rented > 3
      end
      
      # add frequent renter points
      frequent_renter_points += 1
      frequent_renter_points += 1 if current.movie.price_code == Movie::NEW_RELEASE && current.days_rented > 1

      # show figures for rental
      result += "\t#{current.movie.title}\t#{this_amount}\n"
      total_amount += this_amount
    end
    
    # add footer lines
    result += "Amount owed is #{total_amount}\n."
    result += "You earnd #{frequent_renter_points} frequent renter points."
    
    return result
  end
  
  private
    
    attr_accessor :rentals
    attr_writer :name
    
end