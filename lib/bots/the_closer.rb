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
end