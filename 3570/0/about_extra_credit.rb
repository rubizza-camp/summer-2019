# :reek:Attribute
class Player
  attr_accessor :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end
end
# :reek:TooManyStatements
# :reek:UtilityFunction
class Game
  def initialize(*players, times)
    @players = players
    @times = times
  end

  def start
    puts 'start'
    @players.each do |player|
      player.score = score(roll(@times))
    end
  end

  def roll(times)
    values = []
    times.times { values << rand(1..6) }
    values
  end

  def score(dice)
    points = 0
    points += 1000 if dice.count(1) >= 3
    points += (dice.count(1) % 3) * 100
    points += (dice.count(5) % 3) * 50
    points + (2..6).sum { |num| dice.count(num) >= 3 ? num * 100 : 0 }
  end
end

p_one = Player.new('Misha')
p_two = Player.new('Dasha')

game = Game.new(p_one, p_two, 5)
p game
game.start
p p_one
p p_two
