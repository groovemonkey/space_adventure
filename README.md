# Overview #

I tried doing an MVC game with lots of state, and it was a mess. Here, I'll try to implement the same game in a more functional style.

The goals are:
+ Brush up on my Ruby skills after a foray into Clojure.
+ Experiment with random generation of game objects/locations.
+ Build a game that I would love to play.

## Technologies ##
Ruby.

## Build Instructions ##
If you have ruby installed, cloning this repository and running 

```ruby src/application.rb```

 should get you rolling.


## Structure ##

This is an extremely simple little framework, consisting of the following elements:

+The Universe Grid (used for navigation; contains Planets)
+Planets (contain ingame resources, Events, and enemy Ships)
+Events (arbitrary functions that can be triggered by the player visiting a location)
+Players have Ships, which have Weapons.


## Scripting/Extension ##

To extend the game, modify resource files in /resources

Currently, only new Events can be created. After the next push, I will have added the ability to manually script planets as well.
