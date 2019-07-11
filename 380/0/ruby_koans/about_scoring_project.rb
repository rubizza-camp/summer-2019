require File.expand_path(File.dirname(__FILE__) + '/neo')

# rubocop:disable Metrics/MethodLength, Style/Next
# :reek:TooManyStatements, :reek:UtilityFunction
def score(dice)
  score = 0
  dice.each do |points|
    if dice.count(points) >= 3
      score += if points.equal?(1)
                 1000
               else
                 points * 100
               end
      3.times { dice.delete_at(dice.index(points)) }
      next
    end
  end
  dice.each do |points|
    if points == 1
      score += 100
      next
    end
    if points == 5
      score += 50
      next
    end
  end
  score
end
# rubocop:enable Metrics/MethodLength, Style/Next

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
