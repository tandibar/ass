puts "--------------------------"
puts "--- Day One, Ex: 1 -------"
puts "--------------------------"
# Day 1, Hands-On 1, "Getting started with Ruby"
# Excerise One:

# Gib auf vier verschiedene Arten den String "Hello World!"
# viermal auf dem Bildschirm aus. Die unterschiedlichen
# Methoden sollten möglichst kreativ sein!

4.times { puts "Hello World!" }

puts "--------------------------"

print "Hello World!\n" * 4

puts "--------------------------"

for i in 1..4 do
  puts %w(Hello World !).join(' ').sub(/\ !/, '!')
end

puts "--------------------------"

i = 0
while i < 4
  puts "Hello World!"
  i += 1
end

puts "--------------------------"
puts "--- Day One, Ex: 2 -------"
puts "--------------------------"

# Excerise Two

# Eine Liste von Studenten, die Matrikelnummern den Namen
# der Studenten zuweist (mind. 4 Studenten in der Liste).
# Aus dieser Liste sollen die Namen sortiert ausgegeben werden.

students = { 1234 => "John Doe",
             2359 => "Mike Madson",
             7853 => "Jimmy James",
             4568 => "Clark Kent",
             3211 => "Peter Parker"}
             
# students.sort {|a,b| a[1] <=> b[1]}.each { |student| puts student.join(' ') }
students.values.sort.each { |student| puts student }

# hsh = {:test => 'mine!'}
# 
# ret = if hsh[:test]
#   puts "no no no"
#   "test"
# end
# 
# puts ret