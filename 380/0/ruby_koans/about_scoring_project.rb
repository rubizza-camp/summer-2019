require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:UtilityFunction
def score(dice)
  score = 0
  return score if dice.equal?([])
  frequency = times_in(dice)
  points = claculated_from(frequency)
  points
end

# :reek:UtilityFunction
def times_in(dice)
  points = [0, 0, 0, 0, 0, 0]
  dice.each { |side| points[side - 1] += 1 }
  points
end

# :reek:FeatureEnvy, :reek:TooManyStatements:, :reek:UtilityFunction
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity
def claculated_from(freq)
  points = 0
  0.upto(freq.size - 1) do |iterator|
    if freq[iterator] / 3 >= 1 && !freq[iterator].zero?
      points += iterator + 1 == 1 ? 1000 : (iterator + 1) * 100
      freq[iterator] -= (freq[iterator] / 3).ceil * 3
    end
    unless freq[iterator].zero?
      points += freq[iterator] * 100 if (iterator + 1).equal?(1)
      points += freq[iterator] * 50 if (iterator + 1).equal?(5)
    end
  end
  points
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_5zero
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_10zero
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1, 5, 5, 1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2, 3, 4, 6])
  end

  def test_score_of_a_triple_1_is_100zero
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
