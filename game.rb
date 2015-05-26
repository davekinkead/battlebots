lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gosu'
require 'players'


module BattleBots
  class Game < Gosu::Window
    include BattleBots::Players

    attr_accessor :bullets, :players, :explosions

    def initialize(x=1200, y=800, resize=false)
      super
      @players = player_list
      @bullets = []
      @explosions = []
      @winning = Gosu::Sample.new(self, "media/you-win.mp3")
      @winner_played = false
      @font = Gosu::Font.new(self, Gosu::default_font_name, 200)
    end

    def update
      bullets.each do |bullet|
        bullet.move
        bullet.decay
      end
      bullets.delete_if { |bullet| bullet.decayed? }      

      players.each do |player|
        player.hit? bullets
        player.play
      end
      players.delete_if { |player| player.dead? }
    end

    def draw
      [players, bullets, explosions].each do |collection_of_drawables|
        collection_of_drawables.each { |drawable| drawable.draw } 
      end

      if players.length == 1
        display_winner players.first 
      end 
    end

    def button_up(id)
    end

    def button_down(id)
      close if id == Gosu::KbEscape
    end

    private 

    def display_winner(proxy)
      @font.draw("WINNER!", 200, 300, 0, 1.0, 1.0, 0xffffff00)
      unless @winner_played
        @winning.play
        @winner_played = true
      end
    end
  end
end

BattleBots::Game.new.show