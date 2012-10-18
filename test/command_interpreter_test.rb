#require "../src/classes/Commands.rb"
require_relative "../src/classes/Commands.rb"

ci = CommandInterpreter.new

# an event has just happened! find out what game-command function should be executed as a result!
ci.interpret(:viewstats).call
## the called function calls another function, so you should get two different "puts"

