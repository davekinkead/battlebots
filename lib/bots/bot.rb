module BattleBots
  module Bots
    class Bot

      attr_reader :name, :heading, :turn, :drive, :aim, :shoot

      def observe(sensors)
        @x = sensors[:x]
        @y = sensors[:y]
        @contacts = sensors[:contacts]
        @health = sensors[:health]
        @heading = sensors[:heading]
        @turret = sensors[:turret]
      end

      def think
        raise NotImplementedError.new
      end
    end
  end
end