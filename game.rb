lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gosu'
require 'players'


module BattleBots
  class Game < Gosu::Window
    include BattleBots::Players

    attr_accessor :bullets, :players

    def initialize(x=1200, y=800, resize=false)
      super
      @players = player_list
      @bullets = []
    end

    def update
      @bullets.each do |bullet|
        bullet.move
        bullet.decay
      end
      @bullets.delete_if { |bullet| bullet.decayed? }      

      @players.each do |player|
        player.hit? @bullets
        player.play
      end
      @players.delete_if { |player| player.dead? }

    end

    def draw
      @players.each do |player|
        player.draw
      end

      @bullets.each do |bullet|
        bullet.draw
      end
    end

    def button_up(id)
    end

    def button_down(id)
      close if id == Gosu::KbEscape
    end
  end
end

BattleBots::Game.new.show