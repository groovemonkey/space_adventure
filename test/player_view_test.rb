require_relative "../src/views.rb"

# test creating a new player object and getting input.
player = PlayerView.new

# get some raw input
rawinput = player.get_input

# feed that raw input to the input-to-game-command translator.
response = player.input_to_game_command(rawinput)

## TESTING ONLY
# for testing purposes, this returns a string right now. Print the string returned by input_to_game_command
puts(response)
