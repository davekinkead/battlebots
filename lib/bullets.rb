module BattleBots
  class Bullet
    attr_reader :x, :y, :vel_x, :vel_y

    def initialize(window, vector)
      @window = window
      @x, @y, @angle, @vel_x, @vel_y = vector
      @image = Gosu::Image.new(@window, 'media/bullet.png', false)
    end

    def decay
      @vel_x *= 0.95
      @vel_y *= 0.95
    end

    def decayed?
      true if @vel_x.abs < 5 && @vel_y.abs < 5
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