# Application Code
# Main
require_relative "logic.rb"
require_relative "classes/Grid.rb"
require_relative "classes/Player.rb"
require_relative "classes/Ships.rb"


def start_new_game()
  # create universe + player
  worldgrid = Grid.new(3)
  player = Player.new("Dave", Ship.new(), [0,0])
  return [worldgrid, player]
end


##### initialization #####

# MAIN MENU DISPLAY (and get player choice)
choice = display_mainmenu() # returns symbol
if choice == :newgame
  game = start_new_game()
  worldgrid = game[0]
  player = game[1]
  
elsif choice == :viewstats
  if player
    player.displayStats()
  else
    puts "You want to view stats for a player that doesn't exist. Let me get right on that."
    #start code from above
    game = start_new_game()
    worldgrid = game[0]
    player = game[1]
  end
  
elsif choice == :loadgame
  puts "You selected loadgame. Too bad it's not implemented yet."
  ## TODO: Load Game
end




####################
#### MAIN LOOP #####
####################

input = ""
while (choice != :quit) && (input != ["quit"]) && (not player.ship.destroyed)
  # present game to player
  result = presentGameState(player, worldgrid)
  if result == :you_are_dead
    puts "You died..."
    break
  else
  input = get_input()
  # execute the game-command chosen at the main-menu
  process_input(input, player, worldgrid)
  end
  
end

#### shutdown and exit ####
puts "\n\nBye!\n"
## save world/player
## save stats