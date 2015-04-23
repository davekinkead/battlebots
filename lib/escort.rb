require 'bullets'

module BattleBots
  class Escort

    attr_reader :bot

    def initialize(window, name)
      @window = window
      @body_image = Gosu::Image.new(@window, "media/body.png")
      @turret_image = Gosu::Image.new(@window, "media/turret.png")
      @font = Gosu::Font.new(@window, Gosu::default_font_name, 20)

      @x, @y = window.width * rand(), window.height * rand()
      @x_vel = @y_vel = 0.0

      @bot = RandomBot.new
      @name = @bot.name
      @strength = 25

      @heading = 90
      @turret = 33
      @health = 100
      @ammo = 0
    end

    def tick
      @ammo += 1
      observe
      move
      aim
      shoot
    end

    def draw
      @body_image.draw_rot(@x, @y, 1, @heading)
      @turret_image.draw_rot(@x, @y, 1, @turret)
      @font.draw("#{@bot.name}: #{@health.to_i}", @x - 50, @y + 25, 0, 1.0, 1.0, 0xffffff00)
    end


    private


    def observe
    end

    def move
      @heading += @bot.turn

      vel = cap(@bot.drive, 1.0) * 0.25

      @x_vel += Gosu::offset_x(@heading, vel)
      @y_vel += Gosu::offset_y(@heading, vel)

      @x += @x_vel
      @y += @y_vel

      # The world is flat but it has fences
      @x = 0 if @x < 0
      @y = 0 if @y < 0      
      @x = @window.width if @x > @window.width
      @y = @window.height if @y > @window.height

      # Add velocity decay
      @x_vel *= 0.9
      @y_vel *= 0.9
    end

    def aim
      @turret += @bot.aim
    end

    def shoot
      if @ammo > 0 && @bot.shoot
        @ammo -= 50
        @window.bullets << Bullet.new(@window, [@x, @y, @turret, Gosu::offset_x(@turret, @strength), Gosu::offset_x(@turret, @strength)])
      end
    end

    def cap(value, limit)
      value = limit if value > limit
      value
    end
  end
end