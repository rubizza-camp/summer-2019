require File.expand_path(File.dirname(__FILE__) + '/neo')

<<<<<<< HEAD
=======
# rubocop:disable Lint/UnneededCopDisableDirective
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
class DiceSet
  attr_reader :values

  def roll(quantity)
    @values = Array.new(quantity) { rand(1..6) }
  end
end

class AboutDiceProject < Neo::Koan
  def test_can_create_a_dice_set
    dice = DiceSet.new
    assert_not_nil dice
  end

<<<<<<< HEAD
  def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_6
=======
  # rubocop:disable FeatureEnvy
  # rubocop:disable TooManyStatements
  def test_rolling_the_dice_returns_a_set_of_integers_between_one_and_six
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    dice = DiceSet.new

    dice.roll(5)
    assert dice.values.is_a?(Array), 'should be an array'
    assert_equal 5, dice.values.size
    dice.values.each do |value|
<<<<<<< HEAD
      assert value >= 1 && value <= 6, "value #{value} must be between 1 and 6"
=======
      assert value >= 1 && value <= 6, "value #{value} must be between one and six"
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    end
  end

  def test_dice_values_do_not_change_unless_explicitly_rolled
    dice = DiceSet.new
    dice.roll(5)
    first_time = dice.values
    second_time = dice.values
    assert_equal first_time, second_time
  end

  def test_dice_values_should_change_between_rolls
    dice = DiceSet.new

    dice.roll(5)
    first_time = dice.values

    dice.roll(5)
    second_time = dice.values

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
    assert_equal 3, dice.values.size

    dice.roll(1)
    assert_equal 1, dice.values.size
  end
<<<<<<< HEAD
end
=======
  # rubocop:enable FeatureEnvy
  # rubocop:enable TooManyStatements
end
# rubocop:enable Lint/UnneededCopDisableDirective
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
