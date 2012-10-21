require_relative "../resources/tools.rb"
require_relative "../resources/events.rb"

## Command Functions
def load_saved_game()
  puts "loadsavedgame function!"
end



#####################
## COMBAT FUNCTIONS
#####################

def capture_ship(capturer, disabledShip, planet)
  # takes a player object (capturer) and a ship object (ship being captured)
  #add the disabled ship to the @fleet of the capturer
  capturer.fleet << disabledShip
  #remove it from the planet
  planet.enemyships = nil
  # increase player stats
  capturer.ships_captured += 1
end


def get_player_combatchoice(result)
  # takes the result of a combat round -- SYMBOL -- and gives the player a choice about what to do next.
  if result == :ship_disabled
    puts "You've disabled the enemy ship. Do you want to *destroy* it or try to *capture* it?"
    choice = ""
    while not [:capture, :destroy].include?(choice) #limit what the player can pass to our application here.
      choice = get_input()[0].to_sym
    end
    return choice # once the choice is something acceptable, return it.
  end
end


def combat(player, playerShip, enemyShip)
  # manage combat and return the winner
  while not (playerShip.destroyed or enemyShip.destroyed)
    ## player goes first
    result = playerShip.attack(enemyShip, player)
    if result == :ship_disabled
      playerchoice = get_player_combatchoice(result)
      if playerchoice == :capture
        return playerchoice
      else
        player.ships_disabled -= 1 # this will count as a destruction, not a disabling
      end
    end
    puts("\n\n\n#######################\n\n\n")
    
    # if enemy is still alive, enemy attacks player
    unless (enemyShip.destroyed or enemyShip.disabled)
      enemyShip.attack(playerShip)
      puts("\n\n###############\n\n")
    end
    
    ## return result if someone died this round
    if playerShip.destroyed
      return :playerdies
    elsif enemyShip.destroyed
      return :playerwins
    end
  end
end



def return_possible_moves(player, worldgrid)
  # takes player and worldgrid objects, returns an array of possible directions for the player
  location = player.location
  
  possibilities = []
    x = location[0]
    y = location[1]
    
    north = [x, (y+1)]
    south = [x, (y-1)]
    east = [(x+1), y]
    west = [(x-1), y]
    directions = {:north => north, :south => south, :east => east, :west => west}
    
    for dir,loc in directions
      unless worldgrid.getPlanetAt(loc) == nil
        possibilities << dir
      end
    end
    return possibilities
end



def presentGameState(playerObj, worldObj)
    currentplanet = worldObj.getPlanetAt(playerObj.location)
    
    # Engage in combat (if there's a ship at this planet)
    if currentplanet.enemyships
      result = combat(playerObj, playerObj.ship, currentplanet.enemyships)
      if result == :playerwins
        puts("You win!")
      elsif result == :playerdies
        return :you_are_dead
      elsif result == :capture
        if rand(3).even? #50% of the time...
          capture_ship(playerObj, currentplanet.enemyships, currentplanet)
          puts "You successfully board the ship, kill the remaining crew, and take control."
        else
          puts "You try to capture the ship, but the pilot self-destructs before you can board."
          #remove it from the planet
          currentplanet.enemyships = nil
          #give the player credit
          playerObj.ships_destroyed += 1
        end
      end
    end
    
    # fire the event (unless you're on 0,0 -- i.e. just starting)
    unless playerObj.location == [0,0]
      if not currentplanet.event_has_fired
        currentplanet.event.fire(playerObj, worldObj)
        currentplanet.event_has_fired = true
      end
    end
      
    # display Basic Player stats
    puts(playerObj.basicStats(worldObj))
    puts("Your options:
    mine              - try mining minerals from this planet
    move <direction   - move in a direction
    ship              - view ship stats
    stats             - view your player stats and achievements
    ")
end
  


def display_mainmenu()
    playerinput = ""
    while not ["1", "new", "2", "load", "3", "stats", "4", "quit",].include?(playerinput)
      
      print("Welcome to Dave's Space Exploration Game
              1 - Start A *New* Game
              2 - *Load* a Saved Game
              3 - View *Stats*
              4 - *Quit*
              
              ")
      
        playerinput = get_input()
        
        if ["1", "new"].include?(playerinput[0])
          return :newgame
        elsif ["2", "load"].include?(playerinput[0])
          return :loadgame
        elsif ["3", "stats"].include?(playerinput[0])
          return :viewstats
        elsif ["4", "quit"].include?(playerinput[0])
          return :quit
        else puts "That's not a choice."
        end
      end
    end
    

def move_player(direction, playerObj, worldObj)
  #takes a symbol, moved the player there. Presumes that this direction is possible.
  if return_possible_moves(playerObj, worldObj).include?(direction)
  
    location = playerObj.location
    x = location[0]
    y = location[1]
    
    if direction == :north
      playerObj.location = [x, (y+1)]
    elsif direction == :south
      playerObj.location = [x, (y-1)]
    elsif direction == :east
      playerObj.location = [(x+1), y]
    elsif direction == :west
      playerObj.location = [(x-1), y]
    end
  else
    return nil
  end
end


  def process_input(input, playerObj, worldObj)
    #input comes in ["a", "split", "list"]
    command = input[0]
    args = input [1..-1]
    
    case
    when command == "move"
      direction = args[0].to_sym
      if move_player(direction, playerObj, worldObj)
        playerObj.ship.fuel -= 1
        playerObj.fuel_used += 1
      else
        puts "You can't move there, dude."
      end
      
    when command == "stats"
      stats = playerObj.displayStats()
      print(stats)
      #PUTTING A gets() here breaks navigation...why? Is it the return value?
      
    when command == "ship"
      stats = playerObj.ship.displayStats()
      print(stats)
      
    when command == "mine"
      playerObj.mine_planet(worldObj)
      
    when command == "repair"
      points_repaired = playerObj.ship.repair(playerObj.minerals)
      playerObj.minerals -= points_repaired
      playerObj.amount_repaired += points_repaired
      
    when (command == "screw") && (args[0] == "you")
      puts "nah man, screw *YOU*"
    when command == "quit"
      nil
    else
      puts "You can't #{command}. Not right here, and *definitely* not right now."
    end #case
    
  end
