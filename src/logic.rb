require_relative "../resources/tools.rb"
require_relative "../resources/events.rb"

## Command Functions
def load_saved_game()
  puts "loadsavedgame function!"
end


def combat(player, playerShip, enemyShip)
  # manage combat and return the winner
  while not (playerShip.destroyed or enemyShip.destroyed)
    playerShip.attack(enemyShip, player)
    puts("\n\n\n#######################\n\n\n")
    
    unless enemyShip.destroyed
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
    # fire the event (unless you're on 0,0 -- i.e. just starting)
    unless playerObj.location == [0,0]
      if not currentplanet.event_has_fired
        currentplanet.event.fire(playerObj, worldObj)
        currentplanet.event_has_fired = true
      end
    end
    
    if currentplanet.enemyships
      result = combat(playerObj, playerObj.ship, currentplanet.enemyships)
      if result == :playerwins
        puts("You win!")
      elsif result == :playerdies
        return :you_are_dead
      end
    end
      
    # display Basic Player stats
    puts(playerObj.basicStats(worldObj))
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
      
    when (command == "screw") && (args[0] == "you")
      puts "nah man, screw *YOU*"
    when command == "quit"
      nil
    else
      puts "You can't #{command}. Not right here, and *definitely* not right now."
    end #case
    
  end
