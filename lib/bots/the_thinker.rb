require 'bots/bot'

class TheThinker < BattleBots::Bots::Bot

  def initialize
    @name = "The Thinker"
  end

  def think
    enemy = select_target
    
    if enemy
      bearing, distance = calculate_vector_to enemy
      aim_turret(bearing, distance)
      close_the_enemy(bearing, distance) if distance <= 250
    else
      stand_by
    end
  end

  private

  def close_the_enemy(bearing, distance)
    super
    @shoot = distance < 200 ? true : false
  end
end