# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/neo')
# Class about strings
# :reek:TooManyMethods
class AboutStrings < Neo::Koan # rubocop:disable Metrics/ClassLength
  def test_double_quoted_strings_are_strings
    string = 'Hello, World'
    assert_equal true, string.is_a?(String)
  end

  def test_single_quoted_strings_are_also_strings
    string = 'Goodbye, World'
    assert_equal true, string.is_a?(String)
  end

  def test_use_single_quotes_to_create_string_with_double_quotes
    string = 'He said, "Go Away."'
    assert_equal 'He said, "Go Away."', string
  end

  def test_use_double_quotes_to_create_strings_with_single_quotes
    string = "Don't"
    assert_equal "Don't", string
  end

  def test_use_backslash_for_those_hard_cases
    first = "He said, \"Don't\""
    second = 'He said, "Don\'t"'
    assert_equal true, first == second
  end

  def test_use_flexible_quoting_to_handle_really_hard_cases
    first = %(flexible quotes can handle both ' and " characters)
    second = %(!flexible quotes can handle both ' and " characters!)
    third = %(flexible quotes can handle both ' and " characters)
    assert_equal false, first == second
    assert_equal true, first == third
  end

  def test_flexible_quotes_can_handle_multiple_lines
    long_string = '
It was the best of times,
It was the worst of times.
'
    assert_equal 54, long_string.length
    assert_equal 3, long_string.lines.count
    assert_equal"\n", long_string[0, 1]
  end

  def test_here_documents_can_also_handle_multiple_lines
    # rubocop:disable Layout/IndentHeredoc
    long_string =  <<SQL
It was the best of times,
It was the worst of times.
SQL
    # rubocop:enable Layout/IndentHeredoc
    assert_equal 53, long_string.length
    assert_equal 2, long_string.lines.count
    assert_equal 'I', long_string[0, 1]
  end

  def test_plus_will_concatenate_two_strings
    string = 'Hello, ' + 'World'
    assert_equal 'Hello, World', string
  end

  def test_plus_concatenation_will_leave_the_original_strings_unmodified
    hi = 'Hello, '
    there = 'World'
    string = hi + there # rubocop:disable Lint/UselessAssignment
    assert_equal 'Hello, ', hi
    assert_equal 'World', there
  end

  def test_plus_equals_will_concatenate_to_the_end_of_a_string
    hi = 'Hello, '
    there = 'World'
    hi += there
    assert_equal 'Hello, World', hi
  end

  def test_plus_equals_also_will_leave_the_original_string_unmodified
    original_string = 'Hello, '
    hi = original_string
    there = 'World'
    hi += there # rubocop:disable Lint/UselessAssignment
    assert_equal 'Hello, ', original_string
  end

  def test_the_shovel_operator_will_also_append_content_to_a_string
    hi = 'Hello, '
    there = 'World'
    hi += there
    assert_equal 'Hello, World', hi
    assert_equal 'World', there
  end

  def test_the_shovel_operator_modifies_the_original_string
    original_string = 'Hello, '
    hi = original_string
    there = 'World'
    hi += there # rubocop:disable Lint/UselessAssignment
    assert_equal 'Hello, ', original_string

    # THINK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
  end

  def test_double_quoted_string_interpret_escape_characters
    string = "\n"
    assert_equal 1, string.size
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    string = '\n'
    assert_equal 2, string.size
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    string = '\\\''
    assert_equal 2, string.size
    assert_equal "\\'", string
  end

  def test_double_quoted_strings_interpolate_variables
    value = 123
    string = "The value is #{value}"
    assert_equal 'The value is 123', string
  end

  # rubocop:disable Lint/UselessAssignment, Lint/UnneededCopDisableDirective
  def test_single_quoted_strings_do_not_interpolate
    value = 123
    string = "The value is #{value}"
    assert_equal "The value is #{value}", string
  end
  # rubocop:enable Lint/UselessAssignment, Lint/UnneededCopDisableDirective

  def test_any_ruby_expression_may_be_interpolated
    string = "The square root of 5 is #{Math.sqrt(5)}"
    assert_equal 'The square root of 5 is 2.23606797749979', string
  end

  def test_you_can_get_a_substring_from_a_string
    string = 'Bacon, lettuce and tomato'
    assert_equal 'let', string[7, 3]
    assert_equal 'let', string[7..9]
  end

  def test_you_can_get_a_single_character_from_a_string
    string = 'Bacon, lettuce and tomato'
    assert_equal 'a', string[1]

    # Surprised?
  end

  in_ruby_version('1.8') do
    def test_in_older_ruby_single_characters_are_represented_by_integers
      assert_equal __, 'a'
      assert_equal __, 'a' == 97

      assert_equal __,  ('a' + 1) == 'b'
    end
  end

  in_ruby_version('1.9', '2') do
    def test_in_modern_ruby_single_characters_are_represented_by_strings
      assert_equal 'a', 'a'
      assert_equal false, 'a' == 97
    end
  end

  def test_strings_can_be_split
    string = 'Sausage Egg Cheese'
    words = string.split
    assert_equal %w[Sausage Egg Cheese], words
  end

  def test_strings_can_be_split_with_different_patterns
    string = 'the:rain:in:spain'
    words = string.split(/:/)
    assert_equal %w[the rain in spain], words

    # NOTE: Patterns are formed from Regular Expressions.  Ruby has a
    # very powerful Regular Expression library.  We will become
    # enlightened about them soon.
  end

  def test_strings_can_be_joined
    words = %w[Now is the time]
    assert_equal 'Now is the time', words.join(' ')
  end

  def test_strings_are_unique_objects
    first = 'a string'
    second = 'a string'

    assert_equal true, first           == second
    assert_equal true, first.object_id == second.object_id
  end
end
