require File.expand_path(File.dirname(__FILE__) + '/neo')
# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity, Layout/EndAlignment,
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

# :reek:UncommunicativeVariableName
# :reek:UtilityFunction
# :reek:TooManyStatements

def score(dice)
  # You need to write this method
  score = 0
  num_of1 = 0
  num_of2 = 0
  num_of3 = 0
  num_of4 = 0
  num_of5 = 0
  num_of6 = 0
  dice.each do |item|
    if item.eql?(1)
      score += 100
      num_of1 += 1
    end
    num_of2 += 1 if item.eql?(2)
    num_of3 += 1 if item.eql?(3)
    num_of4 += 1 if item.eql?(4)
    if item.eql?(5)
      score += 50
      num_of5 += 1
    end
    num_of6 += 1 if item.eql?(6)
  end
  if num_of1 > 2
    score += 1000
    score -= 300
   end
  score += 200 if num_of2.eql?(3)
  score += 300 if num_of3.eql?(3)
  score += 400 if num_of4.eql?(3)
  if num_of5 > 2
    score += 500
    score -= 150
  end
  score += 600 if num_of6.eql?(3)
  score
end

# :reek:Attribute
# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:TooManyMethods
# :reek:UncommunicativeVariableName
# :reek:UncommunicativeMethodName

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1, 5, 5, 1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2, 3, 4, 6])
  end

  def test_score_of_a_triple_1_is_1000
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
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity, Layout/EndAlignment,
end
