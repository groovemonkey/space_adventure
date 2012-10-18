# game grid
# one planet per square for DEMO
# FUTURE: support less than one planet per square (randomly placed planets), with distance calculations (algebra)
require_relative "Planets.rb"

class Grid
  def initialize(size)
    planetnames = ["Testia", "Khyridia", "Earth", "Mars", "Venus", "Saturn", "Mercury", "Europa", "Pooda", "Beetelgeuse",].shuffle
    @map = {}
    (0...size).each do |x|
      (0...size).each do |y|
        
        ## make sure the planetnames haven't been exhausted
        pname = planetnames.pop
        if pname == nil
          pname = "PlanetTOOMANYNAMES"
        end
        
        # add a gridpoint to the map, along with a planet object
        @map[[x, y]] = Planet.new(pname)
      end
    end
    return @map
  end
  
  def getPlanetAt(coord)
    @map[coord] # returns planet object
  end
  
  def displayGrid()
    @map.each do |coord, planet|
      puts("#{coord} -- Planet: #{planet.displayStats()} \n")
    end
  end
  
end # end Grid class
