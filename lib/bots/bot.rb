module BattleBots
  module Bots
    class Bot

      attr_reader :name

      def observe
        raise NotImplementedError.new
      end

      def turn
        raise NotImplementedError.new
      end

      # Returns a value between 0 and 1
      def drive
        raise NotImplementedError.new
      end

      def aim
        raise NotImplementedError.new
      end

      def shoot
        raise NotImplementedError.new
      end
    end
  end
end