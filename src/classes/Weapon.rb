class Weapon
  attr_accessor :damage, :name
  def initialize(name, damage)
    @name = name
    @damage = damage
  end
end