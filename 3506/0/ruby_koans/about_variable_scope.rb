require File.expand_path(File.dirname(__FILE__) + '/neo')

#:reek:all:
# :nodoc:
class AboutVariableScope < Neo::Koan
  def bark
    # rubocop:disable Lint/UselessAssignment
    noise = 'RUFF'
    # rubocop:enable Lint/UselessAssignment
  end

  def test_noise_is_not_available_in_the_current_scope
    assert_raise(NameError) do
      noise
    end
  end

  def test_we_can_get_noise_by_calling_method
    assert_equal 'RUFF', bark
  end

  # rubocop:disable Lint/UselessAssignment
  inaccessible = 'Outside our universe'
  # rubocop:enable Lint/UselessAssignment
  def test_defs_cannot_access_variables_outside_scope
    # defined? does not return true or false
    assert_equal nil, defined? inaccesible
  end

  # ------------------------------------------------------

  def test_blocks_can_access_variables_outside_scope
    test = 'Hi'
    2.times do
      test = 'Hey'
    end

    assert_equal 'Hey', test
  end

  def test_block_variables_cannot_be_accessed_outside_scope
    2.times do
      # rubocop:disable Lint/UselessAssignment
      x = 0
      # rubocop:enable Lint/UselessAssignment
    end
    assert_equal nil, defined? x
  end

  # ------------------------------------------------------
  # :nodoc:
  class Mouse
    # rubocop:disable Style/ClassVars
    @@total = 0
    # rubocop:enable Style/ClassVars
    # Class variables are prefixed with two '@' characters.

    def initialize(name)
      @name = name
      # Instance variables are prefixed with one '@' character.
      # rubocop:disable Style/ClassVars
      @@total += 1
      # rubocop:enable Style/ClassVars
    end

    attr_reader :name

    def self.count
      @@total
    end
  end

  def test_instance_variable
    oscar = Mouse.new('Oscar')
    assert_equal 'Oscar', oscar.name
  end

  def test_class_variable
    (1..9).each { |i| Mouse.new(i.to_s) }
    # Things may appear easier than they actually are.
    assert_equal 10, Mouse.count
  end

  # Meditate on the following:
  # What is the difference between a class variable and instance variable?

  # ------------------------------------------------------
  # rubocop:disable Style/GlobalVars
  $anywhere = 'Anywhere'
  # rubocop:enable Style/GlobalVars
  # Global variables are prefixed with the '$' character.

  def test_global_variables_can_be_accessed_from_any_scope
    # rubocop:disable Style/GlobalVars
    assert_equal 'Anywhere', $anywhere
    # rubocop:enable Style/GlobalVars
  end

  def test_global_variables_can_be_changed_from_any_scope
    # From within a method
    # rubocop:disable Style/GlobalVars
    $anywhere = 'Here'
    assert_equal 'Here', $anywhere
    # rubocop:enable Style/GlobalVars
  end

  def test_global_variables_retain_value_from_last_change
    # What is $anywhere?
    # rubocop:disable Style/GlobalVars
    assert_equal 'Here', $anywhere
    # rubocop:enable Style/GlobalVars
  end

  def test_global_variables_can_be_changed_from_any_scope_2
    # From within a block
    2.times do
      # rubocop:disable Style/GlobalVars
      $anywhere = 'Hey'
      # rubocop:enable Style/GlobalVars
    end

    # rubocop:disable Style/GlobalVars
    assert_equal 'Hey', $anywhere
    # rubocop:enable Style/GlobalVars
  end
end

# THINK ABOUT IT:
#
# What will $anywhere be down here, outside of the scope of the
# AboutVariableScope class?
