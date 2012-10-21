# game grid
# one planet per square for DEMO
# FUTURE: support less than one planet per square (randomly placed planets), with distance calculations (algebra)
require_relative "Planets.rb"

class Grid
  def initialize(size)
    
    @map = {}
    (0...size).each do |x|
      (0...size).each do |y|
        # add a gridpoint to the map, along with a planet object
          @map[[x, y]] = Planet.new()
      end
    end
    
    ## remove enemy ship from [0,0] and return the map
    @map[[0,0]].enemyships = nil
    return @map
  end
  
  ############################
  
  
  def getPlanetAt(coord)
    @map[coord] # returns planet object
  end
  
  ############################
  
  
  def displayGrid()
    @map.each do |coord, planet|
      puts("#{coord} -- Planet: #{planet.displayStats()} \n")
    end
  end
  
end # end Grid class
