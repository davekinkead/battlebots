require 'bullets'

module BattleBots
  class Escort

    attr_reader :bot, :x, :y

    def initialize(window, name)
      @window = window
      @body_image = Gosu::Image.new(@window, "media/body.png")
      @turret_image = Gosu::Image.new(@window, "media/turret.png")
      @font = Gosu::Font.new(@window, Gosu::default_font_name, 20)

      @x, @y = window.width * rand(), window.height * rand()
      @x_vel = @y_vel = 0.0

      @bot = RandomBot.new
      @name = @bot.name
      @speed, @strength, @stamina, @sight = 25, 25, 25, 25

      @heading = 90
      @turret = 33
      @health = 100
      @ammo = 0
    end

    def tick
      @ammo += 1
      observe_battlespace
      @bot.plan
      move
      aim
      shoot
    end

    def hit?(bullets)
      bullets.reject! do |bullet|
        if Gosu::distance(@x, @y, bullet.x, bullet.y) < 25
          score = 1
          @health -= 10
          true
        end
      end
    end

    def draw
      if @health > 0
        @body_image.draw_rot(@x, @y, 1, @heading)
        @turret_image.draw_rot(@x, @y, 1, @turret)
        @font.draw("#{@bot.name}: #{@health.to_i}", @x - 50, @y + 25, 0, 1.0, 1.0, 0xffffff00)
      end
    end

    def dead?
      true if @health < 1
    end


    private


    def observe_battlespace
      battlespace = {x: @x, y: @y, health: @health, turret: @turret, heading: @heading, contacts: []}

      @window.players.each do |enemy|
        unless @x == enemy.x && @y == enemy.y
          battlespace[:contacts] << [enemy.x, enemy.y]
        end
      end

      @bot.observe battlespace
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
        @window.bullets << Bullet.new(@window, [@x, @y, @turret, Gosu::offset_x(@turret, @strength + @x_vel.abs), Gosu::offset_y(@turret, @strength + @y_vel.abs)])
      end
    end

    def cap(value, limit)
      value = limit if value.abs > limit
      value
    end
  end
end