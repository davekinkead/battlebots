require 'bots/the_closer'

class TheWhinger < TheCloser
  def initialize
    @name = "The Bully"
    @previous_health = 100
  end

  def observe(sensors)
    @previous_health = @health
    super
  end

  def think
    @sound = if @previous_health != @health
      'media/ow.wav'
    else
      nil
    end
    super
  end

  def play_sounds
    @sound
  end
end
