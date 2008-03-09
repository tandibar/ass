puts "--> Proc Objekt"

class Array
  def my_find(find_proc)
    for i in 0...size
      return self[i] if find_proc.call(self[i])
    end
    return nil
  end
end

puts [1,3,5,6,7].my_find Proc.new { |e| e.modulo(2) == 0 }
puts
puts "--> Block to Proc"

class Array
  def my_find(&find_block)
    for i in 0...size
      return self[i] if find_block.call(self[i])
    end
    return nil
  end
end

puts [1,3,5,6,7].my_find { |e| e.modulo(2) == 0 }
puts
puts "--> Block via yield"

class Array
  def my_find
    for i in 0...size
      return self[i] if yield self[i]
    end
    return nil
  end
end

puts [1,3,5,6,7].my_find { |e| e.modulo(2) == 0 }
