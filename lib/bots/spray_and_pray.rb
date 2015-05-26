#require 'byebug'

class SprayAndPray < BattleBots::Bots::Bot

  def initialize
    @name = "Spray and Pray"

    @speed = 40
    @strength = 40
    @stamina = 0
    @sight = 20
  end

  def think
    if in_corner?
      shoot_nearest_enemy(true)
    else
      go_towards_corner
    end

    @turn ||= 0
    @drive ||= 0
    @aim ||= 0
  end

  private
  def in_corner?
    (@x - nearest_corner[:x]).abs < 75 && (@y - nearest_corner[:y]).abs < 75
  end

  # returns if the bot should move
  def shoot_nearest_enemy(can_move)
    enemy = select_target

    if enemy
      bearing, distance = calculate_vector_to(enemy)
      if distance < 500
        aim_turret(bearing, distance)
        if can_move
          close_the_enemy(bearing, distance)
          @turn *= 4
        end
      else
        if can_move
          close_the_enemy(bearing, distance)
          @turn *= 4
        end
      end
    else
      @aim = 1
    end
  end

  def go_towards_corner
    @aim = 0

    bearing, distance = calculate_vector_to(nearest_corner)
    @turn = (@heading - bearing) % 360 > 180 ? 3 : -3
    @drive = 1

    shoot_nearest_enemy(false)
  end

  def nearest_corner
    @nearest_corner ||= begin
      max_x = 1200
      closest_x = @x < 600 ? 0 : max_x

      max_y = 800
      closest_y = @y < 400 ? 0 : max_y

      {x: closest_x, y: closest_y}
    end
  end
end