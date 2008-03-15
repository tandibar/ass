class Rental
  
  attr_reader :movie, :days_rented
  
  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented    
  end

  def get_charge
    # return @amount if @amount
    this_amount = 0
    case movie.price_code
    when Movie::REGULAR
      this_amount += 2
      this_amount += (days_rented - 2) * 1.5 if days_rented > 2
    when Movie::NEW_RELEASE
      this_amount += days_rented * 3
    when Movie::CHILDREN
      this_amount += 1.5
      this_amount += (days_rented - 3) * 1.5 if days_rented > 3
    end
    # @amount = this_amount
    return this_amount
  end
  
  private
  
    attr_writer :movie, :days_rented
    
end