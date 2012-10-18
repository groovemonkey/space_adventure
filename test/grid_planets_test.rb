require_relative "../resources/planets.rb"
require_relative "../src/classes/Grid.rb"

puts "Creating a worldgrid..."
worldgrid = Grid.new(2)
# check out the grid, man!
worldgrid.displayGrid()

#get a specific planet
puts "\n\nYou should see a planet object below."
puts(worldgrid.getPlanetAt([0,0]))
