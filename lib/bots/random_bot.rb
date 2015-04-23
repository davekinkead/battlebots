require 'bots/bot'

class RandomBot < BattleBots::Bots::Bot

  def initialize
    @name = "Random Bot"
  end

  def observe
  end

  def drive
    0.8
  end

  def turn
    -1
  end

  def aim
    3
  end

  def shoot
  end

end