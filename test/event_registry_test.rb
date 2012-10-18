require_relative "../src/classes/EventRegistry.rb"
require_relative "../src/views.rb"

## create a new subsystem -- in this case, a view
testview = PlayerView.new()

## create a new EventRegistry
er = EventRegistry.new()

## subscribe to a test event in the Event-Registry
er.subscribe_to(testview, :printgreeting)

#
## BANG! The event happens!
#

## Notify everyone of the event.
er.notify_subscribers_of(:printgreeting)
