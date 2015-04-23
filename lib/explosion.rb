module BattleBot
  class Explosion

    FRAMES = (1..72)

    def initialize(window, position)
      @x, @y = position
      @flames = FRAMES.map { |i| Gosu::Image.new(@window, Gui.resource_path("images/explosions/explosion2-#{i}.png")) }
    end

    def draw

    end
  end
end