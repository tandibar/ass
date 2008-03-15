class Rental
  
  attr_reader :movie, :days_rented
  
  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented    
  end
  
  private
  
    attr_writer :movie, :days_rented
  
end