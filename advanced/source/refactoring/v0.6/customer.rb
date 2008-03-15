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
      # add frequent renter points
      frequent_renter_points += rental.get_frequent_renter_points

      # show figures for rental
      result += "\t#{rental.movie.title}\t#{rental.get_charge}\n"
      total_amount += rental.get_charge
    end
    
    # add footer lines
    result += "Amount owed is #{total_amount}.\n"
    result += "You earnd #{frequent_renter_points} frequent renter points."
    
    return result
  end
  
  private
    
    attr_accessor :rentals
    attr_writer :name
    
end