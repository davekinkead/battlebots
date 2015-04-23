require 'bots/bot'

class RandomBot < BattleBots::Bots::Bot

  def initialize
    @name = "Random Bot"
  end

  def plan
    # attack the first contact
    if @contacts.first
      enemy = @contacts.first
      attack_bearing = (Math.atan2(enemy[1] - @y, enemy[0] - @x) / Math::PI * 180) + 90
      attack_bearing = attack_bearing.abs if attack_bearing < 0
      attack_distance = Math.sqrt((enemy[0] - @x).abs**2 + (enemy[1]-@y)**2)

      # aim turret towards the first contact
      @aim = (@turret % 360) > attack_bearing ? -1 : 1

      # close the enemy
      if (@heading % 360) > attack_bearing
        @turn = (@heading % 360) - attack_bearing > 180 ? -1 : 1
        @turn = (@heading % 360) - attack_bearing > 180 ? 1 : -1
        @drive = 1
      else
        @turn = attack_bearing - (@heading % 360) > 180 ? 1 : -1
        @turn = attack_bearing - (@heading % 360) > 180 ? -1 : 1
        @drive = 0
      end

      # veer off if getting too close
      @turn = -1 if attack_distance < 150

      # shoot if in range
      @shoot = true if attack_distance < 500
    end
  end
end