require 'bots/the_closer'

class TheWhinger < TheCloser
  def initialize
    @name = "The Winger"
    @previous_health = 100
    @sound = 'media/ow.wav'
  end

  def observe(sensors)
    @previous_health = @health
    super
  end

  def play_sounds
    @sound if @previous_health != @health
  end
end
