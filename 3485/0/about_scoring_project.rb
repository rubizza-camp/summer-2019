# frozen_string_literal: true

# :reek:all
# rubocop:diasble all
require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following 'score' function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
# rubocop:disable Lint/MissingCopEnableDirective, Lint/UselessAssignment
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.
# :reek:TooManyStatements
# :reek:UtilityFunction
def score(dice)
  1.upto(6).inject(0) do |score, key|
    results = dice.count(key)
    if results >= 3
      score += key == 1 ? 1000 : key * 100
      results -= 3
    end
    score = 100 * results if key == 1
    score = 50 * results if key == 5
  end
end

# class
# :reek:UncommunicativeMethodName
class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 0, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 200, score([1, 5, 5, 1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2, 3, 4, 6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1, 1, 1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 0, score([2, 2, 2])
    assert_equal 0, score([3, 3, 3])
    assert_equal 0, score([4, 4, 4])
    assert_equal 0, score([5, 5, 5])
    assert_equal 0, score([6, 6, 6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 0, score([2, 5, 2, 2, 3])
    assert_equal 0, score([5, 5, 5, 5])
    assert_equal 1100, score([1, 1, 1, 1])
    assert_equal 1200, score([1, 1, 1, 1, 1])
    assert_equal 1100, score([1, 1, 1, 5, 1])
  end
end
