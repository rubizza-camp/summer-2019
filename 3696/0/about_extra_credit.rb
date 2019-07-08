# frozen_string_literal: true

# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.
# require File.expand_path(File.dirname(__FILE__) + '/neo')
# Game methods
class Game
  def pop(dice)
    count = 0
    top = dice.first
    while dice.first == top
      count += 1
      dice.shift
    end
    [dice, count, top]
  end

  def score(dice)
    dice = dice.sort
    sum = 0
    while dice.length.positive?
      dice, count, top = pop dice
      sum += aggregate(top, count)
    end
    sum
  end

  def aggregate(top, count)
    sum = 0
    if count >= 3
      count = [0, count - 3].max
      sum += (top == 1 ? 1000 : 100 * top)
    end
    sum += count * 100 if top == 1
    sum += count * 50 if top == 5
    sum
  end

  def info_print(count)
    if count >= 0 && count <= 5
      roll = roll(count)
      puts "Your roll is #{roll}"
      puts "You scored: #{score(roll)} points"
    else
      puts 'You can only roll 0-5 times! Try again later'
    end
  end

  def loop
    puts 'Input a number between 1 and 5'
    result = gets
    if result =~ /^-?[0-9]+$/
      result = result.to_i
      info_print result
    else
      puts 'Invalid input.'
    end
  end

  def roll(count)
    Array.new(count) { rand(1..6) }
  end

  def check
    puts 'Wanna try again?[Y/n]'
    result = gets
    if result.strip.capitalize != 'Y'
      puts 'Okay then, bye'
      return false
    end
    true
  end
end
# For the process of game with a player
class Player
  def initialize
    puts 'Welcome to the game!'
    @game = Game.new
    continue = true
    while continue
      @game.loop
      continue = @game.check
    end
  end
end
Player.new
