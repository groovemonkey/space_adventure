require_relative "../src/classes/Event.rb"

## Note: ALL events must have a 'function' argument that implements a proc.
event01 = Event.new(
  name="Ambushed By Aliens!",
  text="Upon landing your ship, you discover a horde of Poglitalians that have laid an ambush. As soon as you step off your ship's ramp, they begin to charge at you, insane with rage. Since they are 1/8th your size, you and your crew easily fend them off while trying to control your hysterical laughter. When it's all over (i.e. when you've finished murdering every last Poglitalian), you discover the reason for the attack -- the Poglitalians thought you were landing on this planet to steal their cache of credits, which they've been hoarding for years. Suckers.",
  function = Proc.new { |player, world| puts("Playing with your stats!")
                        reward = 10000
                        player.credits += reward
                        player.credits_found += reward
    
    },

)

event02 = Event.new(
  name="test",
  text="testu",
  function=Proc.new {puts "this is a proc that doesn't take args"},

)






#### Big Var With Event Names ###
$eventlist = [event01, event02]
