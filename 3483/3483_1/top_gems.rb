require_relative 'algorim'
require_relative 'parser'
require_relative 'gems_reader'

mass = []

parcer = Parcer.new
oppen = GemFileOpen.new
algoritm = Algoritm.new

(0...oppen.kxm).each do |i|
  mass << parcer.url_info(oppen.injek(i))
end

algoritm.get_top(mass)
