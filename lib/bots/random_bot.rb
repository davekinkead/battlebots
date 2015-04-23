require 'bots/bot'

class RandomBot < BattleBots::Bots::Bot

  def initialize
    @name = "Random Bot"
    @turn = rand() > 0.5 ? -1 : 1
  end

  def observe
  end

  def drive
    1
  end

  def turn
    @turn
  end

  def aim
    @turn * -3
  end

  def shoot
  end

end