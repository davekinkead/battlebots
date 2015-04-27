module BattleBots
  module Bots
    class Bot

      attr_reader :name, :heading, :turn, :drive, :aim, :shoot

      def initialize
        # Give your bot a name
        #
        # Then select your skill matrix
        @speed = @strength = @stamina = @sight = 0.25
        raise NotImplementedError.new "You must impement a #new method"
      end

      def think
        # The Proxy will update your sensors for you
        # All you need to do is implement your AI
        #
        # Rather than deciding what to do and having the game query your 
        # bot for action, the proxy will query your bot for intentions
        # and act on your behalf.
        #
        # The intentions to update are turn (+1 or -1)
        raise NotImplementedError.new "You must implement a #think method"
      end
      

      def observe(sensors)
        @x = sensors[:x]
        @y = sensors[:y]
        @health = sensors[:health]
        @heading = sensors[:heading]
        @turret = sensors[:turret]
        @contacts = sensors[:contacts]
      end 

      def skill_profile
        [@speed, @strength, @stamina, @sight]
      end   
    end
  end
end