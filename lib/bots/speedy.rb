require 'bots/bot'

class Speedy < BattleBots::Bots::Bot

  def initialize
    @name = "Speedy"
    @strength, @speed, @stamina, @sight = [25, 72, 0, 3]
    @aim = 1
    @last_shot = 0
  end

  def think
    toX = 600
    toY = 400
    @last_shot += 1
    @last_shot = 0 if @last_shot == 10000

    bearing, distance = calculate_vector_to({x: toX, y: toY})
    close_the_enemy(bearing, distance)

    enemy = select_target
    if enemy
      @shoot = (@last_shot % 50) == 0
      bearing, distance = calculate_vector_to(enemy)
      aim_turret(bearing, distance)
    else
      @shoot = false
    end

    t = @turret % 360
    h = @heading % 360
    same = (t-h).abs < 5

    if same
      @shoot = false
    end

  end
end
