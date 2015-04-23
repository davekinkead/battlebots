module BattleBots
  class Escort

    attr_reader :bot

    def initialize(window, name)
      @window = window
      @body_image = Gosu::Image.new(@window, "media/body.png")
      @turret_image = Gosu::Image.new(@window, "media/turret.png")
      @x, @y = window.width * rand(), window.height * rand()
      @x_vel = @y_vel = 0.0

      @bot = RandomBot.new
      @name = @bot.name
      @heading = 90
      @turret = 33
    end

    def observe
    end

    def move
      @heading += @bot.turn

      @x_vel += Gosu::offset_x(@heading, @bot.drive)
      @y_vel += Gosu::offset_y(@heading, @bot.drive)

      @x += @x_vel
      @y += @y_vel

      # Turn on infinity space
      @x %= @window.width
      @y %= @window.height

      # Add velocity decay
      @x_vel *= 0.5
      @y_vel *= 0.5
    end

    def aim
      @turret += @bot.aim
    end

    def shoot
    end

    def draw
      @body_image.draw_rot(@x, @y, 1, @heading)
      @turret_image.draw_rot(@x, @y, 1, @turret)
    end
  end
end