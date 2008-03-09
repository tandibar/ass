class Rectangle
  
  attr_accessor :width, :height
  
  # attr_reader :width
  # attr_writer :height
  
  # Konstruktor mit Parametern
  def initialize(width, height)
    # Zwei Instanzvariablen
    @width, @height = width, height # Mehrfachzuweisung ;-)
  end
  
  # # Getter/Setter - non-Ruby Style
  # def width
  #   @width # Es wird IMMER der letzte Wert zurückgegeben, daher oft kein +return+ noetig!
  # end
  # 
  # def width=(width)
  #   @width = width
  # end
  # 
  # def height
  #   @height
  # end
  # 
  # def height=(height)
  #   @height = height
  # end
  
  def area
    height * width
  end
  
  def to_s
    "This is a #{self.class.name} with the dimension: #{width}x#{height}"
  end
  
  protected
    
    def meine_protected_methode
      puts "protected"
    end
  
  private
    
    def meine_private_methode
      puts "private"
    end
  
end

# - Es gibt keine abstrakten Klassen!
# - Es gibt aber Vererbung ...
class Square < Rectangle
  def initialize(width)
    super(width, width)
  end
  
  def width=(width)
    self.height = width
    self.width  = width
  end
  
  private 
    attr_writer :height
end