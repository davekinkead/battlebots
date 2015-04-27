require 'bots/bot'

class TheCloser < BattleBots::Bots::Bot

  def initialize
    @name = "The Closer"
  end

  def think
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
      attack_distance = Math.sqrt((contact[:x] - @x).abs**2 + (contact[:y]-@y)**2)
      if closest.nil? || closest > attack_distance
        closest = attack_distance
        target = contact
      end
    end
    target
  end

  def calculate_vector_to(enemy)
    arctan = (Math.atan2(enemy[:y] - @y, enemy[:x] - @x) / Math::PI * 180)
    bearing = arctan > 0 ? arctan + 90 : (arctan + 450) % 360
    distance = Math.sqrt((enemy[:x] - @x).abs**2 + (enemy[:y]-@y)**2)
    [bearing, distance]
  end

  def aim_turret(bearing, distance)
    @aim = (@turret - bearing) % 360 > 180 ? 1 : -1
    @shoot = distance < 500 ? true : false
  end

  def close_the_enemy(bearing, distance)
    @turn = (@heading - bearing) % 360 > 180 ? 1 : -1
    @drive = 1

    # veer off if getting too close
    @turn = -1 if distance < 200
  end

  def stand_by
    @drive = 0
    @turn = 0
    @shoot = false
  end
end