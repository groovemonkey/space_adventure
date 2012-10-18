require_relative "../resources/ships.rb"
require_relative "../resources/planets.rb"
require_relative "../resources/player.rb"
require_relative "../src/classes/Grid.rb"



# create a ship for the player
newship = Ship.new()
newship.displayStats()

# create player and give him the ship
player = Player.new("Dave", 
                    newship, # player must start with a ship
                    [0, 0],)  # player starts at a location
                    

newship.displayStats();

# create a planet and make sure it generated random humans and minerals
newplanet = Planet.new("Testia")
newplanet.displayStats()

# create a worldgrid
worldgrid = Grid.new(2)
# check out the grid, man!
worldgrid.displayGrid()


