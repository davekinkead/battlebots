require 'bots/the_closer'

class TheChicken < TheCloser

  def initialize
    @name = "The Chicken"
  end

  def think
    enemy = select_target
    
    if enemy
      bearing, distance = calculate_vector_to enemy
      aim_turret(bearing, distance)
      run_away(bearing, distance)
    else
      stand_by
    end
  end

  private

  def run_away(bearing, distance)
    @drive = 1
    @turn = (@heading % 360) > (bearing % 360) ? 1 : -1
  end

end