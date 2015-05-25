require "#{
begin
  dir = File.dirname(__FILE__)
  BOT = Dir.entries(dir)
    .select { |f| f=~ /.rb/ }
    .select { |f| !(f =~ /chicken|hackling|^bot\.rb/) }
    .sample
  BOT_NAME = BOT.gsub('.rb', '').split('_').map(&:capitalize).join
  "#{dir}/#{BOT}"
end
}"

class Hackling < Module.const_get(BOT_NAME)
  def initialize
    @name = "Hackling::#{BOT}"
    @strength = 40
    @speed = 40
    @sight = 15
    @stamina = 5
  end
end
