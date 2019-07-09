require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutControlStatements < Neo::Koan # rubocop:disable Metrics/ClassLength
  def test_if_then_else_statements
    result = if true # rubocop:disable Lint/LiteralAsCondition
               :true_value
             else
               :false_value
             end
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
    result = :true_value if true # rubocop:disable Lint/LiteralAsCondition

    assert_equal :true_value, result
  end

  # rubocop:disable Metrics/MethodLength
  def test_if_statements_return_values
    value = if true # rubocop:disable Lint/LiteralAsCondition
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value

    value = if false # rubocop:disable Lint/LiteralAsCondition
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value

    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end
  # rubocop:enable Metrics/MethodLength

  def test_if_statements_with_no_else_with_false_condition_return_value
    value = :true_value if false # rubocop:disable Lint/LiteralAsCondition
    assert_equal nil, value
  end

  def test_condition_operators
    # rubocop:disable Metrics/LineLength
    assert_equal :true_value, (true ? :true_value : :false_value) # rubocop:disable Lint/LiteralAsCondition
    assert_equal :false_value, (false ? :true_value : :false_value) # rubocop:disable Lint/LiteralAsCondition
    # rubocop:enable Metrics/LineLength
  end

  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true # rubocop:disable Lint/LiteralAsCondition

    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    result = :false_value unless false # rubocop:disable Lint/LiteralAsCondition

    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    result = :true_value unless true # rubocop:disable Lint/LiteralAsCondition

    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false # rubocop:disable Lint/LiteralAsCondition

    assert_equal :false_value, result
  end

  def test_while_statement
    i = 1
    result = 1
    while i <= 10
      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement
    i = 1
    result = 1
    loop do
      break unless i <= 10

      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
               break i if (i % 2).zero?

               i += 1
             end

    assert_equal 2, result
  end

  def test_next_statement
    i = 0
    result = []
    while i < 10
      i += 1
      next if (i % 2).zero?

      result << i
    end
    assert_equal [1, 3, 5, 7, 9], result
  end

  def test_for_statement
    array = %w[fish and chips]
    result = []
    array.each do |item|
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
