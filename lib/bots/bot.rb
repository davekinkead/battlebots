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

      def plan
        raise NotImplementedError.new
      end

      # Returns a value between 0 and 1
      def drive
        raise NotImplementedError.new
      end

      def shoot
        raise NotImplementedError.new
      end
    end
  end
end