class Player
  attr_accessor :name, :ship, :location, :fleet, :fuel_used
  def initialize(name, ship, location)
    @name = name
    @ship = ship
    @location = location
    @fleet = [] # can be filled with captured/bought ship objects
    
    # From StatTracker class
    @enemies_killed = 0
    @fuel_used = 0
    @wrecks_found = 0
    @minerals_found = 0
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
    "Enemies Killed: #{@enemies_killed}
    Fuel Used: #{@fuel_used}
    Wrecks Found: #{@wrecks_found}
    Minerals Found: #{@minerals_found}
    Humans Found: #{@humans_found}
    Crew Lost: #{@crew_lost}
    Ships Owned: #{@ships_owned}
    Damage Done: #{@damage_done}
    Damage Taken: #{@damage_taken}
    Armor Lost: #{@armor_lost}
    Hull Lost: #{@hull_lost}
    Ships Lost: #{@ships_lost}
    Times You've Started The Game': #{@times_started_game}
    Hours Played: #{@hours_played}
    Planets Explored: #{@planets_explored}
    "
  end
  
  
    
end # end player class