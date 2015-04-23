$LOAD_PATH << File.dirname(__FILE__)

require 'gosu'

class BattleBots < Gosu::Window

  def initialize(x=1200, y=800, resize=false)
    super
  end

  def update
  end

  def draw
  end

  def button_up(id)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

BattleBots.new.show