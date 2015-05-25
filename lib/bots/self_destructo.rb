require 'bots/the_closer'

# A bot that moves so fast it constantly crashes into its own bullets.
# (A speed greater than 35 is detrimental to a bots own health.)
class SelfDestructo < TheCloser

  def initialize
    @name = "Self-Destructo"
    @speed = 70
    @strength = 10
    @stamina = 10
    @sight = 10
  end

end