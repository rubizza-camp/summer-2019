require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutVariableScope < Neo::Koan
  # rubocop:disable UselessAssignment
  def bark
    noise = 'RUFF'
  end

  def test_noise_is_not_available_in_the_current_scope
    assert_raise(___) do
      noise
    end
  end

  def test_we_can_get_noise_by_calling_method
    assert_equal __, bark
  end

  inaccessible = 'Outside our universe'
  def test_defs_cannot_access_variables_outside_scope
    # defined? does not return true or false
    assert_equal __, defined? inaccesible
  end
  # rubocop:enable UselessAssignment
  # ------------------------------------------------------
  # rubocop:disable Style/ClassVars
  # :reek:ClassVariable

  def test_blocks_can_access_variables_outside_scope
    test = 'Hi'
    2.times do
      test = 'Hey'
    end

    assert_equal __, test
  end

  # rubocop:disable UselessAssignment
  def test_block_variables_cannot_be_accessed_outside_scope
    2.times do
      x = 0
    end
    assert_equal __, defined? x
  end

  # ------------------------------------------------------
  # rubocop:enable UselessAssignment
  class Mouse
    @@total = 0
    # Class variables are prefixed with two '@' characters.

    def initialize(n_is_variable)
      @name = n_is_variable
      # Instance variables are prefixed with one '@' character.
      @@total += 1
    end

    attr_reader :name

    def self.count
      @@total
    end
  end
  # rubocop:enable Style/ClassVars

  def test_instance_variable
    oscar = Mouse.new('Oscar')
    assert_equal __, oscar.name
  end
  # :reek:UncommunicativeVariableName

  def test_class_variable
    (1..9).each { |i| Mouse.new(i.to_s) }
    # Things may appear easier than they actually are.
    assert_equal __, Mouse.count
  end

  # Meditate on the following:
  # What is the difference between a class variable and instance variable?

  # ------------------------------------------------------
  # rubocop:disable Style/GlobalVars

  $anywhere = 'Anywhere'
  # Global variables are prefixed with the '$' character.

  def test_global_variables_can_be_accessed_from_any_scope
    assert_equal __, $anywhere
  end

  def test_global_variables_can_be_changed_from_any_scope
    # From within a method
    $anywhere = 'Here'
    assert_equal __, $anywhere
  end

  def test_global_variables_retain_value_from_last_change
    # What is $anywhere?
    assert_equal __, $anywhere
  end

  def test_global_variables_can_be_changed_from_any_scope_2
    # From within a block
    2.times do
      $anywhere = 'Hey'
    end

    assert_equal __, $anywhere
    # rubocop:enable Style/GlobalVars
  end
end

# THINK ABOUT IT:
#
# What will $anywhere be down here, outside of the scope of the
# AboutVariableScope class?
