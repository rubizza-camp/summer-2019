# rubocop:disable Lint/LiteralAsCondition
require File.expand_path(File.dirname(__FILE__) + '/neo')

# rubocop:disable Metrics/ClassLength, Style/For
# This method smells of :reek:TooManyStatements
# This method smells of :reek:RepeatedConditional
# This method smells of :reek:FeatureEnvy

class AboutControlStatements < Neo::Koan
  def test_if_then_else_statements
    result = if true
               :true_value
             else
               :false_value
             end
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
    result = :true_value if true
    assert_equal :true_value, result
  end

  # rubocop:enable Metrics/ClassLength
  # rubocop:disable Metrics/MethodLength

  def test_if_statements_return_values
    value = if true
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value

    value = if false
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value
  end

  # rubocop:enable Metrics/MethodLength

  def test_if_statements_with_no_else_with_false_condition_return_value
    value = (:true_value if false)
    assert_equal nil, value
  end

  def test_condition_operators
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
  end

  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true

    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    result = :false_value unless false # same as saying 'if !false', which evaluates as 'if true'
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    result = :true_value unless true # same as saying 'if !true', which evaluates as 'if false'
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false

    assert_equal :false_value, result
  end

  def test_while_statement
    var = 1
    result = 1
    while var <= 10
      result *= var
      var += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement
    var = 1
    result = 1
    loop do
      break unless var <= 10

      result *= var
      var += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement_returns_values
    var = 1
    result = while var <= 10
               break var if var.even?

               var += 1
             end

    assert_equal 2, result
  end

  def test_next_statement
    var = 0
    result = []
    while var < 10
      var += 1
      next if var.even?

      result << var
    end
    assert_equal [1, 3, 5, 7, 9], result
  end

  def test_for_statement
    array = %w[fish and chips]
    result = []
    for item in array
      result << item.upcase
    end
    assert_equal %w[FISH AND CHIPS], result
  end

  def test_times_statement
    sum = 0
    10.times do
      sum += 1
    end
    assert_equal 10, sum
  end
end

# rubocop:enable Lint/LiteralAsCondition, Style/For
