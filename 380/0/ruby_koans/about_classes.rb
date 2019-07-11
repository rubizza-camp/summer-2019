require File.expand_path(File.dirname(__FILE__) + '/neo')
# rubocop:disable Metrics/LineLength
# :reek:Attribute, :reek:FeatureEnvy, :reek:UncommunicativeMethodName, :reek:UncommunicativeVariableName, :reek:UncommunicativeModuleName, :reek:TooManyStatements,:reek:TooManyMethods, :reek:InstanceVariableAssumption
# rubocop:enable Metrics/LineLength

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  class DogTwo
    attr_accessor a_name
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = DogTwo.new
    assert_equal [], fido.instance_variables

    fido.set_name('Fido')
    assert_equal [:@name], fido.instance_variables
  end

  # rubocop:disable Style/EvalWithLocation
  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = DogTwo.new
    fido.set_name('Fido')

    assert_raise(NoMethodError) do
      fido.name
    end
    assert_raise(Exception) do
      eval 'fido.@name'
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values
    fido = DogTwo.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.instance_variable_get('@name')
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    fido = DogTwo.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.instance_eval('@name') # string version
    assert_equal 'Fido', (fido.instance_eval { @name }) # block version
  end
  # rubocop:enable Style/EvalWithLocation

  class DogThree
    attr_reader :name
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = DogThree.new
    fido.name('Fido')

    assert_equal 'Fido', fido.name
  end

  # rubocop:disable Naming/AccessorMethodName
  class DogFour
    attr_reader :name

    def set_name(a_name)
      @name = a_name
    end
  end
  # rubocop:enable Naming/AccessorMethodName

  def test_attr_reader_will_automatically_define_an_accessor
    fido = DogFour.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  class DogFive
    attr_accessor :name
  end

  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = DogFive.new

    fido.name = 'Fido'
    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  class DogSix
    attr_reader :name
    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = DogSix.new('Fido')
    assert_equal 'Fido', fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      DogSix.new
    end
    # THINK ABOUT IT:
    # Why is this so?
  end

  def test_different_objects_have_different_instance_variables
    fido = DogSix.new('Fido')
    rover = DogSix.new('Rover')

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  class DogSeven
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    # rubocop:disable Naming/AccessorMethodName
    def get_self
      self
    end
    # rubocop:enable Naming/AccessorMethodName

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
    fido = DogSeven.new('Fido')

    fidos_self = fido.get_self
    assert_equal fido, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = DogSeven.new('Fido')
    assert_equal 'Fido', fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = DogSeven.new('Fido')
    assert_equal "My dog is #{fido}", "My dog is #{fido}"
  end

  # rubocop:disable Style/StringLiterals
  def test_all_objects_support_to_s_and_inspect
    array = [1, 2, 3]
    assert_equal '[1, 2, 3]', array.to_s
    assert_equal '[1, 2, 3]', array.inspect

    assert_equal 'STRING', 'STRING'.to_s
    assert_equal "\"STRING\"", 'STRING'.inspect
  end
  # rubocop:enabled Style/StringLiterals

  def test_inspect_provides_a_more_complete_string_version
    fido = DogSeven.new('Fido')
    assert_equal "<Dog named '#{fido}'>", fido.inspect
  end
  # rubocop:enabled Naming/AccessorMethodName
  # rubocop:enabled Style/EvalWithLocation
end
