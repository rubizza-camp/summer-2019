require File.expand_path(File.dirname(__FILE__) + '/neo')
# :reek:all
# documentation comment
class DiceSet
  attr_reader :roll_results

  def roll(num_rolls)
    @roll_results = Array.new(num_rolls) { rand(1..6) }
  end
end
# documentation comment
class AboutDiceProject < Neo::Koan
  def test_can_create_a_dice_set
    dice = DiceSet.new
    assert_not_nil dice
  end

  def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_6
    dice = DiceSet.new

    dice.roll(5)
    assert dice.roll_results.is_a?(Array), 'should be an array'
    assert_equal 5, dice.roll_results.size
    dice.roll_results.each do |value|
      assert value >= 1 && value <= 6, "value #{value} must be between 1 and 6"
    end
  end

  def test_dice_values_do_not_change_unless_explicitly_rolled
    dice = DiceSet.new
    dice.roll(5)
    first_time = dice.roll_results
    second_time = dice.roll_results
    assert_equal first_time, second_time
  end

  def test_dice_values_should_change_between_rolls
    dice = DiceSet.new

    dice.roll(5)
    first_time = dice.roll_results

    dice.roll(5)
    second_time = dice.roll_results

    assert_not_equal first_time, second_time,
                     'Two rolls should not be equal'

    # THINK ABOUT IT:
    #
    # If the rolls are random, then it is possible (although not
    # likely) that two consecutive rolls are equal.  What would be a
    # better way to test this?
  end

  def test_you_can_roll_different_numbers_of_dice
    dice = DiceSet.new

    dice.roll(3)
    assert_equal 3, dice.roll_results.size

    dice.roll(1)
    assert_equal 1, dice.roll_results.size
  end
end
