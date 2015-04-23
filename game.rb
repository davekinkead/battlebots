lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gosu'

module BattleBots
  class Game < Gosu::Window

    def initialize(x=1200, y=800, resize=false)
      super
      @players = load_players
    end

    def update
      @players.each do |player|
        player.observe
        player.aim
        player.shoot
        player.move
      end
    end

    def draw
      @players.each do |player|
        player.draw
      end
    end

    def button_up(id)
    end

    def button_down(id)
      close if id == Gosu::KbEscape
    end

    private

    def load_players(players=nil)
      require 'escort'
      require 'bots/random_bot'
      @players = [Escort.new(self, RandomBot)]
    end
  end
end

BattleBots::Game.new.show