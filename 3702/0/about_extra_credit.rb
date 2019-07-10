# frozen_string_literal: true

class Game
  def deposit
    @deposit
  end

  def initialize(gamer)
    @gamer = gamer
    @deposit = 1_000_000
  end
  
  attr_reader :gamer

  def deposit_minus(win_user)
    @deposit -= win_user
    puts "DEPOSIT #{deposit}"
  end

  def deposit_plus(pay)
    puts "DEPOSIT #{deposit}"
    @deposit += pay
    puts "DEPOSIT #{deposit}"
  end

  def roll(n)
    @roll = []
    n.times { @roll << (rand(n) + 1) }
    puts "ВЫПАЛО #{@roll}"
    win_user
  end

  def values
    @roll
  end

  def win_user
    case values
    when [1, 1, 1, 1, 1]
      gamer.kesh_plus(1000)
      deposit_minus(1000)
      1000
    when [2, 2, 2, 2, 2]
      gamer.kesh_plus(2000)
      deposit_minus(2000)
      2000
    when [3, 3, 3, 3, 3]
      gamer.kesh_plus(3000)
      deposit_minus(3000)
      3000
    when [4, 4, 4, 4, 4]
      gamer.kesh_plus(5000)
      deposit_minus(5000)
      5000
    when [5, 5, 5, 5, 5]
      gamer.kesh_plus(7000)
      deposit_minus(7000)
      7000
    when [6, 6, 6, 6, 6, 6]
      gamer.kesh_plus(10_000)
      deposit_minus(10_000)
      10_000
    else
      deposit_plus(1000)

      gamer.kesh_minus(1000)
    end
  end
end

class Gamer
  attr_reader :name

  def kesh
    @kesh
  end

  def kesh_minus(pay)
    p "КЕШ= #{kesh}"
    @kesh -= pay
    p "КЕШ= #{kesh}"
    puts 'You lost'
  end

  def kesh_plus(pay)
    p "КЕШ= #{kesh}"
    @kesh += pay
    p "КЕШ= #{kesh}"
    puts 'You win'
  end

  def initialize(name)
    @name = name
    @kesh = 500_000
  end
end

vasya = Gamer.new('vasya')
gaime = Game.new(vasya)

while vasya.kesh >= 1000
  gaime.roll(5)
  p "vasya КЕШ= #{vasya.kesh}"
end

puts 'GAME OVER'
