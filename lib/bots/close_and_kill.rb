require 'bots/bot'

class CloseAndKill < BattleBots::Bots::Bot

  def initialize
    @name = "Random Bot"
  end

  def think
    # attack the closest contact
    enemy = select_target
    
    if enemy
      bearing, distance = calculate_vector_to enemy
      aim_turret(bearing, distance)
      close_the_enemy(bearing, distance)
    else
      stand_by
    end
  end

  private

  def select_target
    closest = target = nil
    @contacts.each do |contact|
      attack_distance = Math.sqrt((contact[0] - @x).abs**2 + (contact[1]-@y)**2)
      if closest.nil? || closest > attack_distance
        closest = attack_distance
        target = contact
      end
    end
    target
  end

  def calculate_vector_to(enemy)
    attack_bearing = (Math.atan2(enemy[1] - @y, enemy[0] - @x) / Math::PI * 180) + 90
    attack_bearing = attack_bearing.abs if attack_bearing < 0
    attack_distance = Math.sqrt((enemy[0] - @x).abs**2 + (enemy[1]-@y)**2)
    [attack_bearing, attack_distance]
  end

  def aim_turret(attack_bearing, attack_distance)
    @aim = (@turret % 360) > attack_bearing ? -1 : 1
    @shoot = true if attack_distance < 500
  end

  def close_the_enemy(attack_bearing, attack_distance)
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
  end

  def stand_by
    @drive = 0
    @turn = 0
    @shoot = false
  end
end