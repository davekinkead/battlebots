require 'bots/bot'
dir = File.dirname(__FILE__)
bots = Dir.entries(dir)
  .select { |f| f=~ /.rb/ }
  .select { |f| !(f =~ /troublemaker|^bot\.rb/) }

bots.each do |bot|
  bot_name = bot.gsub('.rb', '').split('_').map(&:capitalize).join

  Module.const_get(bot_name).class_eval do
    define_method :initialize do
      @name = bot_name
    end

    define_method :think do
      stand_by
    end
  end
end

class TheTroublemaker < BattleBots::Bots::Bot
  def initialize
    @name = "TheTroublemaker"
  end

  def think
    enemy = select_target

    if enemy
      bearing, distance = calculate_vector_to enemy
      aim_turret(bearing, distance)
      close_the_enemy(bearing, distance)
    else
      stand_by
    end
  end
end


