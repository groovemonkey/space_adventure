require_relative "../../resources/tools.rb"
require_relative "../../resources/weapons.rb"

class Ship
  attr_accessor :weapons, :weapon_mounts, :fuel, :name, :destroyed, :disabled
  
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
    @disabled = false
    @destroyed = false
    @weapon_mounts = rand(8) + 1 # min 1
    @weapons = []
    @crew = rand(20)
    @max_fuel = rand(10) + 3 # min 3
    @fuel = @max_fuel # newly created ships have a full tank of gas
    @free_cargo = @max_cargo # created with empty cargo hold
    @max_armor = @armor
    @max_hull = @hull
  
    
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
  
  
  
  
  def repair(minerals)
    # takes minerals, repairs the ship back up to max_health (depending on minerals)
    # returns leftover mineral number.
    initial_minerals = minerals
    
    while (@max_hull > @hull) && (minerals > 0)
        @hull += 1
        minerals -= 1
    end
    
    while (@max_armor > @armor) && (minerals > 0)
      @armor += 1
      minerals -= 1
    end
    
    repaired = initial_minerals - minerals
    puts "Used #{repaired} minerals to repair your ship.\n"
    return repaired
  end
  
  
  
  
  def displayStats()
    "\nShip Stats:
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
    free cargo: #{@free_cargo}\n"
  end
  
  
  
  def take_damage(amount)
    armor_left = @armor
    hull_left = @hull
    
    # if there's armor over the hull...
    if armor_left > 0
      if (armor_left - amount) <= 0
        @armor = 0
        return :armor_empty
      else
        @armor -= amount
        return :armor_damaged
      end
      
    # if the armor is gone, but some hull integrity remains...
    elsif hull_left > 0
      if (hull_left - amount) <= 0
        @hull = 0
        @destroyed = true
        return :destroyed #if the hull is breached, the ship dies
      else
        @hull -= amount
        if @hull < 50
          self.disabled = true
          return :ship_disabled
        else
          return :hull_damaged
        end
      end
      
    # no armor, no hull...
    else
      return "this ship should already be disabled. This shouldn't be possible."
    end
  end
  
  
  def attack(target, player=nil)
    #attack another ship object
    # if the player object is passed in, the player is performing the attack
    # -- use proper wording for the play-by-play reports.
    if player
      targetname = "the #{target.name}'s"
      attackername = "You fire your"
      disabledname = "the #{target.name}"
    else
      targetname = "your"
      attackername = "The #{@name} fires its"
      disabledname = "your ship"
    end
    
    
    @weapons.each do |weaponsymbol|
      weapon = $weaponlist[weaponsymbol]
      damage = weapon.damage
      
      result = target.take_damage(damage)
      
      if result == :armor_damaged
        puts "\n#{attackername} #{weapon.name}, hitting #{targetname} armor for #{damage} damage."
        sleep(1)
        
      elsif result == :armor_empty
        puts "\n#{attackername} #{weapon.name}, destroying #{targetname} armor."
        sleep(1)
        
      elsif result == :hull_damaged
        puts "\n#{attackername} #{weapon.name}, hitting #{targetname} hull for #{damage} damage."
        sleep(1)
        
      elsif result == :ship_disabled
        puts "\n#{attackername} #{weapon.name}, disabling #{disabledname}."
        player.ships_disabled += 1 if player
        return :ship_disabled
        
      elsif result == :destroyed
        puts "\n#{attackername} #{weapon.name}, smashing through #{targetname} hull and destroying it completely. Everyone inside is killed instantly."
        player.ships_destroyed += 1 if player
        sleep(1)
        break
      end
      
      ## add appropriate stats to the player
        player.damage_done += damage if player
    end
  end
  
  
  
end # end ship class




class EnemyShip < Ship
  
end




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


