require_relative "../../resources/events.rb"
require_relative "Ships.rb"

class Planet
  attr_accessor :event, :event_has_fired, :minerals, :enemyships
  def initialize()
    planetnames = ["Testia", "Khyridia", "Earth", "Mars", "Venus", "Saturn", "Mercury", "Europa", "Pooda", "Beetelgeuse",].shuffle
    ## make sure the planetnames haven't been exhausted
        pname = planetnames.pop
        if pname == nil
          pname = "PlanetTOOMANYplanets"
        end
        
    @name = pname
    # randomly generate humans, minerals
    @humans = ((rand * 100) / 4).floor
    @minerals = (rand * 100).floor
    @event = $eventlist[rand($eventlist.length)]
    @event_has_fired = false
    
    @enemyships = nil
    @enemyships = EnemyShip.new() if rand(4) == 3
    
  end
  
  def displayStats()
    # returns a string
    "#{@name}. On this planet, you found
    #{@humans} humans and
    #{@minerals} kg of minerals."
  end
  
  def getMinedBy(playerObj)
    amount = @minerals
    if amount > 0
      playerObj.minerals += amount
      playerObj.minerals_mined += amount
      @minerals = 0
      puts "You just mined #{amount} kg of rare minerals from #{@name}."
    else
      puts "There are no minerals to mine on #{@name}."
    end
  end
  
end

