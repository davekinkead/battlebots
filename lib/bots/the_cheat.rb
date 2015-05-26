# A bot that hacks the brains of other bots
class TheCheat < BattleBots::Bots::Bot

  def initialize
    puts "initialize"
    @name      = "The Cheat"
    @speed     = 10
    @strength  = 40
    @stamina   = 0
    @sight     = 25
    @first_run = true


  end

  def think
    if @first_run
      override_brain
      emp
      @first_run = false
    end

    enemy = select_target

    if enemy
      bearing, distance = calculate_vector_to enemy
      aim_turret(bearing, distance)
      close_the_enemy(bearing, distance)
    else
      stand_by
    end

  end


  private

  def override_brain
    ObjectSpace.each_object BattleBots::Game do |game|
      game.players.each do |player|
        bot = player.bot
        unless bot == self
          bot.class.send(:alias_method, :old_think, :think)
          bot.class.send(:alias_method, :old_select_target, :select_target)
        end
      end
    end
  end

  def emp
    ObjectSpace.each_object BattleBots::Game do |game|
      game.players.each do |player|
        bot = player.bot
        unless bot == self
          def bot.name=(name)
            @name = name
          end
          bot.name = "[disabled]" + bot.name
          def bot.think
            @heading = 0
            @turn    = 0
            @drive   = 0
            @aim     = 0
            @shoot   = false
          end
        else
          @player = player
        end
      end
    end

  end
end