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
    result = "Rental Record for #{name}:\n"
    
    rentals.each do |rental|
      # show figures for rental
      result += "\t#{rental.movie.title}\t#{rental.get_charge}\n"
    end
    
    # add footer lines
    result += "Amount owed is #{total_charge}.\n"
    result += "You earnd #{total_frequent_renter_points} frequent renter points."
    
    return result
  end
  
  def html_statement
    # add header line
    result = "<h1>Rental Record for <em>#{name}</em>:</h1><ul>"
    
    # add rentals
    rentals.each do |rental|
      result += "<li>#{rental.movie.title}: #{rental.get_charge}</li>"
    end
    
    # add footer lines
    result += "</ul><p>You owe <em>#{total_charge}</em>."
    result += "On this rental you earnd <em>#{total_frequent_renter_points}</em> frequent renter points.</p>"
    
    return result
  end
  
  private
    
    attr_accessor :rentals
    attr_writer :name
    
    def total_charge
      total_charge = 0.0
      rentals.each do |rental|
        total_charge += rental.get_charge
      end
      return total_charge
    end
    
    def total_frequent_renter_points
      total_frequent_renter_points = 0
      rentals.each { |rental| total_frequent_renter_points += rental.get_frequent_renter_points }
      return total_frequent_renter_points
    end
    
end