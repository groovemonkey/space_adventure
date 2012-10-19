require_relative "../src/classes/Weapon.rb"

laser_cannon = Weapon.new("laser cannon", 40)

### Big Var that contains all weapon objects
$weaponlist = {:laser_cannon => laser_cannon}
