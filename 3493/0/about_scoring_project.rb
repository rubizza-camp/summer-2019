require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
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
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.
# :reek:UtilityFunction:

def check_set_of_three_ones(array)
  if array[0] >= 3
    array[0] -= 3
    return 1000
  end
  0
end
# :reek:UtilityFunction:

def check_set_of_three_fives(array)
  if array[4] >= 3
    array[4] -= 3
    return 500
  end
  0
end
# :reek:UtilityFunction:

def check_set_of_three(array, iteration)
  return 100 * (iteration + 1) if array[iteration] == 3

  0
end
# :reek:FeatureEnvy:reek:TooManyStatements:reek:UtilityFunction:

def check_everything(array)
  result = 0
  (0..5).each do |iteration|
    result += check_set_of_three(array, iteration)
    if (array[iteration] < 3) && array[iteration].positive?
      result += 50 * array[iteration] if iteration == 4
      result += 100 * array[iteration] if iteration.zero?
    end
  end
  result
end
# :reek:NestedIterators:reek:TooManyStatements:

def score(dice)
  array = []
  result = 0
  (1..6).each do |iteration|
    array.append(dice.select { |item| item == iteration }.count)
  end
  result += check_set_of_three_ones(array)
  result += check_set_of_three_fives(array)
  result += check_everything(array)
  result
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_fifth
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_hungred
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1, 5, 5, 1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2, 3, 4, 6])
  end

  def test_score_of_a_triple_1_is_thousend
    assert_equal 1000, score([1, 1, 1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2, 2, 2])
    assert_equal 300, score([3, 3, 3])
    assert_equal 400, score([4, 4, 4])
    assert_equal 500, score([5, 5, 5])
    assert_equal 600, score([6, 6, 6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2, 5, 2, 2, 3])
    assert_equal 550, score([5, 5, 5, 5])
    assert_equal 1100, score([1, 1, 1, 1])
    assert_equal 1200, score([1, 1, 1, 1, 1])
    assert_equal 1150, score([1, 1, 1, 5, 1])
  end
end
