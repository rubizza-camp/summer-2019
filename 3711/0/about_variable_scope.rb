require File.expand_path(File.dirname(__FILE__) + '/neo')

# rubocop:disable Lint/UselessAssignment
# rubocop:disable Style/GlobalVars
# :reek:ClassVariable and :reek:UncommunicativeMethodName
# :reek:UncommunicativeParameterName and :reek:UncommunicativeVariableName
class AboutVariableScope < Neo::Koan
  def bark
    noise = 'RUFF'
  end

  def test_noise_is_not_available_in_the_current_scope
    assert_raise(NameError) do
      noise
    end
  end

  def test_we_can_get_noise_by_calling_method
    assert_equal 'RUFF', bark
  end

  inaccessible = 'Outside our universe'
  def test_defs_cannot_access_variables_outside_scope
    # defined? does not return true or false
    assert_equal nil, defined? inaccesible
  end

  # ------------------------------------------------------

  # rubocop:disable Style/EachForSimpleLoop
  def test_blocks_can_access_variables_outside_scope
    test = 'Hi'
    (1..2).each do
      test = 'Hey'
    end

    assert_equal 'Hey', test
  end

  def test_block_variables_cannot_be_accessed_outside_scope
    (1..2).each do
      x = 0
    end
    assert_equal nil, defined? x
  end
  # rubocop:enable Style/EachForSimpleLoop

  # ------------------------------------------------------

  # rubocop:disable Style/ClassVars
  # rubocop:disable Style/TrivialAccessors
  # rubocop:disable Style/ClassMethods
  class Mouse
    @@total = 0
    # Class variables are prefixed with two '@' characters.

    # rubocop:disable Naming/UncommunicativeMethodParamName
    def initialize(n)
      @name = n
      # Instance variables are prefixed with one '@' character.
      @@total += 1
    end
    # rubocop:enable Naming/UncommunicativeMethodParamName

    def name
      @name
    end

    def Mouse.count
      @@total
    end
  end
  # rubocop:enable Style/ClassVars
  # rubocop:enable Style/TrivialAccessors
  # rubocop:enable Style/ClassMethods

  def test_instance_variable
    oscar = Mouse.new('Oscar')
    assert_equal 'Oscar', oscar.name
  end

  # rubocop:disable Style/UnneededInterpolation
  def test_class_variable
    (1..9).each { |i| Mouse.new("#{i}") }
    # Things may appear easier than they actually are.
    assert_equal 10, Mouse.count
  end
  # rubocop:enable Style/UnneededInterpolation

  # Meditate on the following:
  # What is the difference between a class variable and instance variable?

  # ------------------------------------------------------

  $anywhere = 'Anywhere'
  # Global variables are prefixed with the '$' character.

  def test_global_variables_can_be_accessed_from_any_scope
    assert_equal 'Anywhere', $anywhere
  end

  def test_global_variables_can_be_changed_from_any_scope
    # From within a method
    $anywhere = 'Here'
    assert_equal 'Here', $anywhere
  end

  def test_global_variables_retain_value_from_last_change
    # What is $anywhere?
    assert_equal 'Here', $anywhere
  end

  # rubocop:disable Style/EachForSimpleLoop
  def test_global_variables_can_be_changed_from_any_scope_2
    # From within a block
    (1..2).each do
      $anywhere = 'Hey'
    end

    assert_equal 'Hey', $anywhere
  end
  # rubocop:enable Style/EachForSimpleLoop
end
# rubocop:enable Lint/UselessAssignment
# rubocop:enable Style/GlobalVars

# THINK ABOUT IT:
#
# What will $anywhere be down here, outside of the scope of the
# AboutVariableScope class?
