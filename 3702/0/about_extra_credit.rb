# class Game
#   attr_reader :deposit, :gamer

#   def initialize(gamer)
#     @gamer = gamer
#     @deposit = 1_000_000
#   end

#   def deposit_minus(win_user)
#     @deposit -= win_user
#     puts "DEPOSIT #{deposit}"
#   end

#   def deposit_plus(pay)
#     puts "DEPOSIT #{deposit}"
#     @deposit += pay
#     puts "DEPOSIT #{deposit}"
#   end

#   def roll(num)
#     @roll = []
#     num.times { @roll << (rand(num) + 1) }
#     puts "ВЫПАЛО #{@roll}"
#     win_user
#   end

#   def values
#     @roll
#   end

#   def win_user
#     case values
#     when [1, 1, 1, 1, 1] then kesh_plus(1000)
#     when [2, 2, 2, 2, 2] then kesh_plus(2000)
#     when [3, 3, 3, 3, 3] then kesh_plus(3000)
#     when [4, 4, 4, 4, 4] then kesh_plus(5000)
#     when [5, 5, 5, 5, 5] then kesh_plus(7000)
#     when [6, 6, 6, 6, 6, 6] then kesh_plus(11_000)
#     else kesh_minus
#     end
#   end

#   def kesh_plus(win)
#     gamer.kesh_plus(win)
#     deposit_minus(win)
#   end

#   def kesh_minus
#     deposit_plus(1000)
#     gamer.kesh_minus(1000)
#   end
# end

# class Gamer
#   attr_reader :name

#   attr_reader :kesh

#   def kesh_minus(pay)
#     p "КЕШ= #{kesh}"
#     @kesh -= pay
#     p "КЕШ= #{kesh}"
#     puts 'You lost'
#   end

#   def kesh_plus(pay)
#     p "КЕШ= #{kesh}"
#     @kesh += pay
#     p "КЕШ= #{kesh}"
#     puts 'You win'
#   end

#   def initialize(name)
#     @name = name
#     @kesh = 500_000
#   end
# end

# vasya = Gamer.new('vasya')
# gaime = Game.new(vasya)

# while vasya.kesh >= 1000
#   gaime.roll(5)
#   p "vasya КЕШ= #{vasya.kesh}"
# end

# puts 'GAME OVER'
