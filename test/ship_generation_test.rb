require_relative "../resources/ships.rb"

testship = Ship.new()

puts "\nGrabbing a description from your new ship...\n\n"
string = testship.displayStats()
puts(string)
