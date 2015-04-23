require 'proxy'
require 'bots/the_closer'
require 'bots/the_bully'
require 'bots/the_chicken'

module BattleBots
  module Players

    def player_list
      [
        Proxy.new(self, TheCloser), 
        Proxy.new(self, TheBully), 
        Proxy.new(self, TheChicken)]
    end
  end
end