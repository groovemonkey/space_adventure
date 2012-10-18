# Event Structure:
# name -- a headline like "You've been ambushed by pirates!"
# text
# function = a proc that contains the function which affects game state -- takes player health, fuel, adds money, etc.

class Event
  # randomly generate an event.
  def initialize(name, text, function)
    @name = name
    @text = text
    @function = function
  end
  
  # fire MUST be called with player and world objects as arguments.
  def fire(playerObj, worldObj)
    puts(@name + "\n\n" + @text)
    gets()
    @function.call(playerObj, worldObj)
  end
  
end