do_something = Proc.new { puts "Irgendwas was gemacht wird." }

def ensure_important_stuff(any_proc)
  puts "Sehr wichtige Sache, die vorher gemacht werden muss!"
  any_proc.call
  puts "Sehr wichtige Sache, die nachher gemacht werden muss!"
end