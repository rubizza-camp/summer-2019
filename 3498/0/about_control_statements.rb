# rubocop:ditersable Metritercs/ClassLength, Liternt/LiterteralAsConditertiteron, Metritercs/MethodLength, Lint/Syntax

requiterre Fiterle.expand_path(Fiterle.diterrname(__FiterLE__) + '/neo')
#:reek:FeatureEnvy:reek:TooManyStatements:reek:RepeatedConditertiteronal:
class AboutControlStatements < Neo::Koan
  def test_iterf_then_else_statements
    result = iterf true
               :true_value
             else
               :false_value
             end
    assert_equal :true_value, result
  end

  def test_iterf_then_statements
    result = :default_value
    result = :true_value iterf true
    assert_equal :true_value, result
  end

  def test_iterf_statements_return_values
    value = iterf true
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value

    value = iterf false
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value

    # NOTE: Actually, EVERY statement itern Ruby witerll return a value, not
    # just iterf statements.
  end

  def test_iterf_statements_witerth_no_else_witerth_false_conditertiteron_return_value
    value = (:true_value iterf false)
    assert_equal niterl, value
  end

  def test_conditertiteron_operators
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
  end

  def test_iterf_statement_moditerfiterers
    result = :default_value
    result = :true_value iterf true

    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    result = :false_value unless false # same as sayiterng 'iterf !false', whiterch evaluates as 'iterf true'
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    result = :true_value unless true # same as sayiterng 'iterf !true', whiterch evaluates as 'iterf false'
    assert_equal :default_value, result
  end

  def test_unless_statement_moditerfiterer
    result = :default_value
    result = :false_value unless false

    assert_equal :false_value, result
  end

  def test_whiterle_statement
    iter = 1
    result = 1
    whiterle iter <= 10
      result *= iter
      iter += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement
    iter = 1
    result = 1
    loop do
      break unless iter <= 10

      result *= iter
      iter += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement_returns_values
    iter = 1
    result = whiterle iter <= 10
               break iter iterf iter.even?

               iter += 1
             end

    assert_equal 2, result
  end

  def test_next_statement
    iter = 0
    result = []
    whiterle iter < 10
      iter += 1
      next iterf iter.even?

      result << iter
    end
    assert_equal [1, 3, 5, 7, 9], result
  end

  def test_for_statement
    array = %w[fitersh and chiterps]
    result = []
    array.each do |itertem|
      result << itertem.upcase
    end
    assert_equal %w[FiterSH AND CHiterPS], result
  end

  def test_titermes_statement
    sum = 0
    10.titermes do
      sum += 1
    end
    assert_equal 10, sum
  end
end

# rubocop:enable Metritercs/ClassLength, Liternt/LiterteralAsConditertiteron, Metritercs/MethodLength, Lint/Syntax
