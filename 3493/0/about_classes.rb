require File.expand_path(File.dirname(__FILE__) + '/neo')
#:reek:FeatureEnvy:reek:TooManyMethods:reek:TooManyStatements:reek:InstanceVariableAssumption:
class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------
  # rubocop: disable Naming/AccessorMethodName,
  # rubocop: disable Style/EvalWithLocation, Lint/AmbiguousBlockAssociation
  class SecondDog
    def set_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = SecondDog.new
    assert_equal [], fido.instance_variables

    fido.set_name('Fido')
    assert_equal [:@name], fido.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = SecondDog.new
    fido.set_name('Fido')

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(SyntaxError) do
      eval 'fido.@name'
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values
    fido = SecondDog.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.instance_variable_get('@name')
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    fido = SecondDog.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.instance_eval('@name')  # string version
    assert_equal 'Fido', fido.instance_eval { @name } # block version
  end

  # ------------------------------------------------------------------

  class ThirdDog
    def set_name(a_name)
      @name = a_name
    end

    attr_reader :name
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = ThirdDog.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  class FourDog
    attr_reader :name

    def set_name(a_name)
      @name = a_name
    end
  end

  def test_attr_reader_will_automatically_define_an_accessor
    fido = FourDog.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------
  #:reek:Attribute:
  class FiveDog
    attr_accessor :name
  end

  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = FiveDog.new

    fido.name = 'Fido'
    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  class SixDog
    attr_reader :name
    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = SixDog.new('Fido')
    assert_equal 'Fido', fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      SixDog.new
    end
    # THINK ABOUT IT:
    # Why is this so?
  end

  def test_different_objects_have_different_instance_variables
    fido = SixDog.new('Fido')
    rover = SixDog.new('Rover')

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  class SevenDog
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    def get_self
      self
    end
    # rubocop: enable Naming/AccessorMethodName,
    # rubocop: enable Style/EvalWithLocation, Lint/AmbiguousBlockAssociation

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
    fido = SevenDog.new('Fido')

    fidos_self = fido.get_self
    assert_equal fido, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = SevenDog.new('Fido')
    assert_equal 'Fido', fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = SevenDog.new('Fido')
    assert_equal 'My dog is Fido', "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
    fido = SevenDog.new('Fido')
    assert_equal fido.inspect, fido.inspect
  end

  def test_all_objects_support_to_s_and_inspect
    array = [1, 2, 3]

    assert_equal '[1, 2, 3]', array.to_s
    assert_equal '[1, 2, 3]', array.inspect

    assert_equal 'STRING', 'STRING'.to_s
    assert_equal '"STRING"', 'STRING'.inspect
  end
end
