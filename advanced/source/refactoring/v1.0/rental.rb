class Rental
  
  attr_reader :movie, :days_rented
  
  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented    
  end

  def get_charge
    @amount ||= movie.get_charge(days_rented)
  end
  
  def get_frequent_renter_points
    movie.get_frequent_renter_points(days_rented)
  end
  
  private
  
    attr_writer :movie, :days_rented
    
end