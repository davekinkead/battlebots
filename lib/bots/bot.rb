module BattleBots
  module Bots
    class Bot

      DEFAULT_SKILL_LEVEL = 0.25

      attr_reader :name, :heading, :turn, :drive, :aim, :shoot


      def initialize
        # Give your bot a name
        #
        # Then select your skill matrix
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
        [@speed, @strength, @stamina, @sight].map do |skill| 
          skill ||= DEFAULT_SKILL_LEVEL
        end
      end   

      private

      def select_target
        closest = target = nil
        @contacts.each do |contact|
          attack_distance = Math.sqrt((contact[:x] - @x).abs**2 + (contact[:y]-@y)**2)
          if closest.nil? || closest > attack_distance
            closest = attack_distance
            target = contact
          end
        end
        target
      end

      def calculate_vector_to(enemy)
        arctan = (Math.atan2(enemy[:y] - @y, enemy[:x] - @x) / Math::PI * 180)
        bearing = arctan > 0 ? arctan + 90 : (arctan + 450) % 360
        distance = Math.sqrt((enemy[:x] - @x).abs**2 + (enemy[:y]-@y)**2)
        [bearing, distance]
      end

      def aim_turret(bearing, distance)
        @aim = (@turret - bearing) % 360 > 180 ? 1 : -1
        @shoot = distance < 400 ? true : false
      end

      def close_the_enemy(bearing, distance)
        @turn = (@heading - bearing) % 360 > 180 ? 1 : -1
        @drive = 1

        # veer off if getting too close
        @turn = -1 if distance < 200
      end

      def run_away(bearing, distance)
        @drive = 1
        @turn = (@heading % 360) >= (bearing % 360) ? 1 : -1
      end

      def stand_by
        @aim = 1
        @drive = 0
        @turn = 0
        @shoot = false
      end
    end
  end
end