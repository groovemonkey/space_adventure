require_relative "../../resources/tools.rb"

class Ship
  attr_accessor :weapons, :weapon_mounts, :fuel
  
  def initialize()
      ## come up with stats
    if rare?
      @armor = rand_range(400, 4000)
      @hull = rand_range(700, 7000)
      @max_cargo = rand_range(100, 1000)
    else
      @armor = rand(400)
      @hull = rand(700)
      @max_cargo = rand(100) + 5 # max_cargo -- min 5
    end
    
    @name = generate_shipname()
    @weapon_mounts = rand(8) + 1 # min 1
    @weapons = []
    @crew = rand(20)
    @max_fuel = rand(10) + 3 # min 3
    @fuel = @max_fuel # newly created ships have a full tank of gas
    @free_cargo = @max_cargo # created with empty cargo hold
  
    
    # generate weapons for each weapon mount
    @weapon_mounts.times do
      @weapons << :laser_cannon #TODO: implement a weapon list and choose weapons randomly
    end
  
  # calculate the value
    if rand(100) == 42 # sometimes you just get a great deal...
      @value = (@armor + @hull + @max_cargo) * 5
    else # most of the time, you don't
      @value = (@armor + @hull + @max_cargo + (@weapon_mounts * 100) + @max_fuel) * 100
    end
  end
  
  
  def displayStats()
    "Your Ship Stats:
    name: #{@name}
    value: #{@value}
    armor: #{@armor}
    hull strength: #{@hull}
    weapon mounts: #{@weapon_mounts}
    weapons: #{@weapons}
    crew: #{@crew}
    max fuel: #{@max_fuel}
    fuel remaining: #{@fuel}
    max cargo: #{@max_cargo}
    free cargo: #{@free_cargo}"
  end
  
end # end ship class






def generate_shipname()
  adjectives = ["Ogglebotty", "Luna", "Martian", "Venusian", "Darkstar", "Kerellia"]
  nouns = ["Screamer", "Kerellian", "Killer", "Survivor", "Freight Train", "Mule", "Corvette", "Viper"]
  suffixes = ["Type I", "Type II", "Type 42", "Mark 7", "Mark 42", "Jr.", "Sr.", "The Third"]

  name = ""
  if rand(100) > 20 # 20% of  ships don't have adjectives
    name += adjectives.shuffle[1] + " " # shuffle the adjectives and add one to the name, plus a space
  end
  
  name += nouns.shuffle[1]
  
  if rand(100) > 90 # only 9% of ships have suffixes
    name += " " + suffixes.shuffle[1]
  end
  
  return name
end





def generate_ship()
  ## come up with stats
  if rare?
    armor = rand_range(400, 4000)
    hull = rand_range(700, 7000)
    cargo = rand_range(100, 1000)
  else
    armor = rand(400)
    hull = rand(700)
    cargo = rand(100) + 5 # max_cargo -- min 5
  end
  
  
  # creates a ship object and returns it
  ship = Ship.new(generate_shipname(),
                  armor,
                  hull,
                  rand(8) + 1, # weapon mounts -- min 1
                  [], # weapons
                  rand(20), # crew
                  rand(10) + 3, # MAX FUEL -- min 3
                  cargo,
                  )
                  
  # generate weapons for each weapon mount
  ship.weapon_mounts.times do
    ship.weapons << :laser_cannon #TODO: implement a weapon list and choose weapons randomly
  end
  
  # return the new ship object
  return ship
end


