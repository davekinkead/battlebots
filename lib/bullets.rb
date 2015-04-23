module BattleBots
  class Bullet
    attr_reader :x, :y

    def initialize(window, vector)
      @window = window
      @x, @y, @angle, @vel_x, @vel_y = vector
      @image = Gosu::Image.new(@window, 'media/bullet.png', false)
    end

    def decay
      @vel_x *= 0.9
      @vel_y *= 0.9
    end

    def decayed?
      true if @vel_x.abs < 3 && @vel_y.abs < 3
    end

    def move
      @x += @vel_x
      @y += @vel_y
    end

    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end  
  end
end