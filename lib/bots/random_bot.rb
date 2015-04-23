require 'bots/bot'

class RandomBot < BattleBots::Bots::Bot

  def initialize
    @name = "Random Bot"
    @turn = rand() > 0.5 ? -1 : 1
  end

  def plan
    # attack the first contact
    enemy = @contacts.first
    attack_vector = (Math.atan2(enemy[1] - @y, enemy[0] - @x) / Math::PI * 180) + 90
    attack_vector = attack_vector.abs if attack_vector < 0

    # aim turret towards the first contact
    @aim = (@turret % 360) > attack_vector ? -1 : 1

    # turn randomly
    incr = rand() * 10
    pole *= -1 if incr > 8
    @turn += (pole * incr) 
  end

  def drive
    1
  end

  def shoot
    true
  end
end