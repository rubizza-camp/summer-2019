require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:TooManyMethods:
# :reek:Lint/UnneededCopEnableDirective:
# :reek:Metrics/ClassLength:
class AboutStrings < Neo::Koan
  # rubocop: enable Metrics/ClassLength
  def test_double_quoted_strings_are_strings
    stringg = 'Hello, World'
    assert_equal true, stringg.is_a?(String)
  end

  def test_single_quoted_strings_are_also_strings
    stringg = 'Goodbye, World'
    assert_equal true, stringg.is_a?(String)
  end

  def test_use_single_quotes_to_create_string_with_double_quotes
    stringg = 'He said, "Go Away."'
    assert_equal 'He said, "Go Away."', stringg
  end

  def test_use_double_quotes_to_create_strings_with_single_quotes
    stringg = "Don't"
    assert_equal "Don't", stringg
  end

  def test_use_backslash_for_those_hard_cases
    a_said = "He said, \"Don't\""
    b_said = 'He said, "Don\'t"'
    assert_equal true, a_said == b_said
  end

  def test_use_flexible_quoting_to_handle_really_hard_cases
    a_flex = %(flexible quotes can handle both ' and " characters)
    b_flex = %(flexible quotes can handle both ' and " characters)
    c_flex = %(flexible quotes can handle both ' and " characters)
    assert_equal true, a_flex == b_flex
    assert_equal true, a_flex == c_flex
  end

  def test_flexible_quotes_can_handle_multiple_lines
    long_string = %(
It was the best of times,
It was the worst of times.
)
    assert_equal 54, long_string.length
    assert_equal 3, long_string.lines.count
    assert_equal "\n", long_string[0, 1]
  end

  def test_here_documents_can_also_handle_multiple_lines
    long_string = <<~OOS
      It was the best of times,
      It was the worst of times.
    OOS
    assert_equal 53, long_string.length
    assert_equal 2, long_string.lines.count
    assert_equal 'I', long_string[0, 1]
  end

  def test_plus_will_concatenate_two_strings
    stringg = 'Hello, ' + 'World'
    assert_equal 'Hello, World', stringg
  end

  def test_plus_concatenation_will_leave_the_original_strings_unmodified
    hiii = 'Hello, '
    there = 'World'
    stringg = hiii + there
    assert_equal 'Hello, ', hiii
    assert_equal 'World', there
  end

  def test_plus_equals_will_concatenate_to_the_end_of_a_hi
    hiii = 'Hello, '
    there = 'World'
    hiii += there
    assert_equal 'Hello, World', hiii
  end

  def test_plus_equals_also_will_leave_the_original_string_unmodified
    original_string = 'Hello, '
    hiii = original_string
    there = 'World'
    hiii += there
    assert_equal 'Hello, ', original_string
  end

  def test_the_shovel_operator_will_also_append_content_to_a_string
    hiii = 'Hello, '
    there = 'World'
    hiii << there
    assert_equal 'Hello, World', hiii
    assert_equal 'World', there
  end

  def test_the_shovel_operator_modifies_the_original_string
    original_string = 'Hello, '
    hiii = original_string
    there = 'World'
    hiii << there
    assert_equal 'Hello, World', original_string

    # ThiNK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
  end

  def test_double_quoted_string_interpret_escape_characters
    stringg = "\n"
    assert_equal 1, stringg.size
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    stringg = '\n'
    assert_equal 2, stringg.size
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    stringg = '\\\''
    assert_equal 2, stringg.size
    assert_equal "\\\'", stringg
  end

  def test_double_quoted_strings_interpolate_variables
    value = 123
    stringg = "The value is #{value}"
    assert_equal 'The value is 123', stringg
  end

  def test_single_quoted_strings_do_not_interpolate
    valuee = 123
    # :reek:Lint/InterpolationCheck:
    stringg = 'The value is #{valuee}'
    assert_equal 'The value is #{valuee}', stringg
    # rubocop: enable Lint/InterpolationCheck, Lint/UselessAssignment
  end

  def test_any_ruby_expression_may_be_interpolated
    stringg = "The square root of 5 is #{Math.sqrt(5)}"
    assert_equal "The square root of 5 is #{Math.sqrt(5)}", stringg
  end

  def test_you_can_get_a_substring_from_a_string
    stringg = 'Bacon, lettuce and tomato'
    assert_equal 'let', stringg[7, 3]
    assert_equal 'let', stringg[7..9]
  end

  def test_you_can_get_a_single_character_from_a_string
    stringg = 'Bacon, lettuce and tomato'
    assert_equal 'a', stringg[1]

    # Surprised?
  end

  in_ruby_version('1.8') do
    def test_in_older_ruby_single_characters_are_represented_by_integers
      assert_equal __, 'a'
      assert_equal __, 'a' == 97

      assert_equal __, ('a' + 1) == 'b'
    end
  end

  in_ruby_version('1.9', '2') do
    def test_in_modern_ruby_single_characters_are_represented_by_strings
      assert_equal 'a', 'a'
      assert_equal false, 'a' == 97
    end
  end

  def test_his_can_be_split
    stringg = 'Sausage Egg Cheese'
    words = stringg.split
    assert_equal %w[Sausage Egg Cheese], words
  end

  def test_strings_can_be_split_with_different_patterns
    stringg = 'the:rain:in:spain'
    words = stringg.split(/:/)
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
    a_str = 'a string'
    b_str = 'a string'

    assert_equal true, a_str           == b_str
    assert_equal false, a_str.object_id == b_str.object_id
  end
end
