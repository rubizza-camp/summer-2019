# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:InstanceVariableAssumption
# :reek:TooManyStatements
# :reek:UncommunicativeMethodName
# :reek:FeatureEnvy

class DiceSet
  attr_reader :values

  def roll(value)
    array = (1..value).to_a
    @values = array
  end

  class AboutDiceProject < Neo::Koan
    def test_can_create_a_dice_set
      dice = DiceSet.new
      assert_not_nil dice
    end

    def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_6
      dice = DiceSet.new

      @five = 5
      min = 1
      max = 6
      dice.roll(@five)
      assert dice.values.is_a?(Array), 'should be an array'
      assert_equal @five, dice.values.count
      dice.values.each do |value|
        assert value >= min && value <= max, "value #{value} must be between 1 and 6"
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
      @five = 5
      dice.roll(@five)
      first_time = dice.values.shuffle

      dice.roll(@five)
      second_time = dice.values.shuffle

      assert_not_equal first_time, second_time,
                       'Two rolls should not be equal'
    end

    def test_you_can_roll_different_numbers_of_dice
      dice = DiceSet.new

      dice.roll(3)
      assert_equal 3, dice.values.count

      dice.roll(1)
      assert_equal 1, dice.values.count
    end
  end
end
