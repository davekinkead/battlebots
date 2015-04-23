require 'bots/the_closer'

class TheBully < TheCloser

  def initialize
    @name = "The Bully"
  end

  private

  def select_target
    target = nil
    @contacts.each do |contact|
      if target.nil? || target[2] > contact[2]
        target = contact
      end
    end
    target
  end

end