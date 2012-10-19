class Player
  attr_accessor :name, :ship, :location, :fleet, :fuel_used, :credits, :credits_earned, :credits_found, :minerals, :minerals_mined, :damage_taken, :damage_done
  def initialize(name, ship, location)
    # Basic Stats
    @name = name
    @ship = ship
    @location = location
    @fleet = [] # can be filled with captured/bought ship objects
    @credits = 1000
    @minerals = 0
    
    # Achievement Stats
    @credits_earned = 0
    @credits_found = 0
    @enemies_killed = 0
    @fuel_used = 0
    @wrecks_found = 0
    @minerals_mined = 0
    @humans_found = 0
    @crew_lost = 0
    @ships_owned = 0
    @damage_done = 0
    @damage_taken = 0
    @armor_lost = 0
    @hull_lost = 0
    @ships_lost = 0
    @times_started_game = 0
    @hours_played = 0
    @planets_explored = 0
  end
  
  
  def displayStats()
    "Credits Earned: #{@credits_earned}
    Credits Found: #{@credits_found}
    Enemies Killed: #{@enemies_killed}
    Fuel Used: #{@fuel_used}
    Wrecks Found: #{@wrecks_found}
    Minerals Mined: #{@minerals_mined}
    Humans Found: #{@humans_found}
    Crew Lost: #{@crew_lost}
    Ships Owned: #{@ships_owned}
    Damage Done: #{@damage_done}
    Damage Taken: #{@damage_taken}
    Armor Lost: #{@armor_lost}
    Hull Lost: #{@hull_lost}
    Ships Lost: #{@ships_lost}
    Times You've Started The Game: #{@times_started_game}
    Hours Played: #{@hours_played}
    Planets Explored: #{@planets_explored}\n\n
    "
  end
  
  def basicStats(worldObj)
    "\n\nYou are #{@name} (type 'stats' to see your player stats)
    Your location is #{@location}
    Your ship: #{@ship.name()} (type 'ship' to see ship stats)
    Your fleet is #{@fleet}\n\n
    You're On Planet #{worldObj.getPlanetAt(@location).displayStats()}
    Your movement options are #{return_possible_moves(self, worldObj)}.
    "
  end
  
  def mine_planet(worldObj)
    planet = worldObj.getPlanetAt(@location)
    planet.getMinedBy(self)
  end
  
  
    
end # end player class