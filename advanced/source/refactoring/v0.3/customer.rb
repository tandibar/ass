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
    
    rentals.each do |rental|
      this_amount = 0

      this_amount = amount_for(rental)
      # add frequent renter points
      frequent_renter_points += 1
      frequent_renter_points += 1 if rental.movie.price_code == Movie::NEW_RELEASE && rental.days_rented > 1

      # show figures for rental
      result += "\t#{rental.movie.title}\t#{this_amount}\n"
      total_amount += this_amount
    end
    
    # add footer lines
    result += "Amount owed is #{total_amount}.\n"
    result += "You earnd #{frequent_renter_points} frequent renter points."
    
    return result
  end
  
  private
    
    attr_accessor :rentals
    attr_writer :name
    
    def amount_for(rental)
      this_amount = 0
      case rental.movie.price_code
      when Movie::REGULAR
        this_amount += 2
        this_amount += (rental.days_rented - 2) * 1.5 if rental.days_rented > 2
      when Movie::NEW_RELEASE
        this_amount += rental.days_rented * 3
      when Movie::CHILDREN
        this_amount += 1.5
        this_amount += (rental.days_rented - 3) * 1.5 if rental.days_rented > 3
      end
      return this_amount
    end
end