module BattleBots
  class Explosion

    FRAMES = (1..71)

    def initialize(x, y, bang, flames)
      @x, @y = x, y
      @flames = flames
      @decay = FRAMES.size
      bang.play
    end

    def self.frames
      FRAMES
    end

    def draw
      if @decay > 0
        @flames[FRAMES.size - @decay].draw_rot(@x, @y, 1, 1)
        @decay -= 1
      end
    end
  end
end